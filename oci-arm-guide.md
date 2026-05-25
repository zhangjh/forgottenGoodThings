# Oracle Cloud ARM 实例抢购指南

## 脚本位置
`/root/.openclaw/workspace/oci-arm-retry.sh`

## 四个必填变量的获取方式

### 1. COMPARTMENT_ID（租户/隔间OCID）
- OCI控制台 → Identity & Security → Compartments
- 复制 root compartment 的 OCID
- 格式：`ocid1.tenancy.oc1..xxxx`
- 也可以用：右上角头像 → Tenancy → 复制 OCID

### 2. AVAILABILITY_DOMAIN（可用性域）
- 查询命令：
```bash
oci iam availability-domain list --compartment-id "<COMPARTMENT_ID>"
```
- 格式类似：`Ixxxx:AP-TOKYO-1-AD-1`
- 东京区域通常只有1个AD

### 3. SUBNET_ID（子网OCID）
- OCI控制台 → Networking → Virtual Cloud Networks → 点进VCN → **Subnets** → 点进子网 → 复制OCID
- ⚠️ 注意是 **subnet** 不是 VCN！
- 格式：`ocid1.subnet.oc1.ap-tokyo-1.xxxx`
- 选 **public subnet**（需要公网IP的话）
- 查询命令：
```bash
oci network subnet list --compartment-id "<COMPARTMENT_ID>" --vcn-id "<VCN_ID>"
```

### 4. IMAGE_ID（镜像OCID）
- ⚠️ ARM实例必须用 **aarch64** 架构的镜像
- 查询命令：
```bash
oci compute image list \
  --compartment-id "<COMPARTMENT_ID>" \
  --shape "VM.Standard.A1.Flex" \
  --operating-system "Canonical Ubuntu" \
  --query 'data[0].id' --raw-output
```
- 也可以在控制台创建实例时选镜像，从URL里复制image OCID

## 运行方式

```bash
chmod +x oci-arm-retry.sh
# 前台运行（看实时输出）
./oci-arm-retry.sh

# 后台运行
nohup ./oci-arm-retry.sh > oci-retry.log 2>&1 &
tail -f oci-retry.log
```

## 常见报错

| 错误 | 原因 | 解决 |
|------|------|------|
| NotAuthenticated (401) | API Key未配置 | 运行 `oci setup config` 并上传公钥到控制台 |
| NotAuthorizedOrNotFound (404) | OCID填错 | 逐个验证：`oci network subnet get --subnet-id xxx` |
| Out of capacity | 正常，容量不足 | 继续等，脚本会自动重试 |
| LimitExceeded | 超出免费配额 | 检查是否已有ARM实例在运行 |

## Free Tier 配额提醒
- AMD：最多2台 VM.Standard.E2.1.Micro（各1/8 OCPU + 1GB）
- ARM：最多4 OCPU + 24GB RAM（可自由分配）
- 引导卷：总共200GB
- AMD和ARM配额独立，可同时使用
