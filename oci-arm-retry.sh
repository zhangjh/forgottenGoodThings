#!/bin/bash
# Oracle Cloud ARM实例抢购脚本
# 使用OCI CLI反复尝试创建ARM实例，直到成功
# 
# 使用前：
# 1. 安装OCI CLI: https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm
# 2. 配置OCI CLI: oci setup config
# 3. 修改下面的变量为你的实际值

# ============ 必须修改的参数 ============
COMPARTMENT_ID="ocid1.tenancy.oc1..xxxxxx"          # 你的租户/隔间OCID
AVAILABILITY_DOMAIN="xxxx:AP-TOKYO-1-AD-1"           # 可用性域
SUBNET_ID="ocid1.subnet.oc1.ap-tokyo-1.xxxxxx"      # 子网OCID
IMAGE_ID="ocid1.image.oc1.ap-tokyo-1.xxxxxx"        # 镜像OCID (Ubuntu/Oracle Linux ARM版)
SSH_KEY_FILE="$HOME/.ssh/id_rsa.pub"                  # SSH公钥路径
DISPLAY_NAME="arm-instance"                           # 实例名称

# ============ 可选参数 ============
OCPUS=4                    # CPU核数 (免费最多4)
MEMORY_IN_GBS=24           # 内存GB (免费最多24)
BOOT_VOLUME_SIZE=50        # 引导卷大小GB
RETRY_INTERVAL=60          # 重试间隔(秒)，别太频繁避免被限流

# ============ 脚本逻辑 ============
echo "=== Oracle ARM实例抢购脚本 ==="
echo "每 ${RETRY_INTERVAL} 秒尝试一次，直到成功"
echo "按 Ctrl+C 停止"
echo ""

attempt=0
while true; do
    attempt=$((attempt + 1))
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] 第 $attempt 次尝试..."

    result=$(oci compute instance launch \
        --compartment-id "$COMPARTMENT_ID" \
        --availability-domain "$AVAILABILITY_DOMAIN" \
        --shape "VM.Standard.A1.Flex" \
        --shape-config "{\"ocpus\": $OCPUS, \"memoryInGBs\": $MEMORY_IN_GBS}" \
        --image-id "$IMAGE_ID" \
        --subnet-id "$SUBNET_ID" \
        --display-name "$DISPLAY_NAME" \
        --boot-volume-size-in-gbs "$BOOT_VOLUME_SIZE" \
        --ssh-authorized-keys-file "$SSH_KEY_FILE" \
        --assign-public-ip true \
        2>&1)

    if echo "$result" | grep -q '"lifecycle-state"'; then
        echo ""
        echo "✅ 创建成功！"
        echo "$result" | grep -E '"id"|"display-name"|"lifecycle-state"|"public-ip"'
        
        # 发送通知（可选，取消注释使用）
        # curl -s "https://api.telegram.org/bot<TOKEN>/sendMessage?chat_id=<CHAT_ID>&text=OCI+ARM实例创建成功！"
        
        break
    elif echo "$result" | grep -qi "out of capacity\|out of host capacity\|capacity"; then
        echo "   ❌ 容量不足，${RETRY_INTERVAL}秒后重试..."
    elif echo "$result" | grep -qi "limit\|quota"; then
        echo "   ⚠️ 配额限制，检查你的Free Tier额度"
        echo "   $result"
        break
    else
        echo "   ❌ 其他错误："
        echo "   $result" | head -5
        echo "   ${RETRY_INTERVAL}秒后重试..."
    fi

    sleep $RETRY_INTERVAL
done
