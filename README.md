# SL3000（128GB eMMC）固件说明文档

本项目基于 **ImmortalWrt MT7981 EMMC 平台**，针对配备 **128GB eMMC** 的 SL3000 进行深度优化，提供高性能、稳定、极简的路由器固件构建方案。

---

## 🧩 1. 设备硬件参数（SL3000 128GB 版）

| 项目 | 参数 |
|------|------|
| SoC | MediaTek MT7981B（双核 A53 1.3GHz） |
| RAM | 1GB DDR4 |
| Flash | **128GB eMMC（超大容量）** |
| WiFi | MT7976C（2.4G + 5G） |
| LAN/WAN | 1× WAN + 3× LAN（千兆） |
| 加速引擎 | HNAT + HWNAT + Flow Offload |
| USB | 无 |
| 按键 | Reset |
| 指示灯 | Power / WiFi / LAN |

---

## 🚀 2. 固件特性

### ✅ 性能优化
- HNAT / HWNAT / Flow Offload 全加速  
- MTK 官方 WiFi 驱动  
- 内核裁剪，移除无关模块  
- ccache 加速编译（固定 key，命中率高）

### ✅ 系统特性
- 完整支持 **128GB eMMC**  
- rootfs / overlay 空间极大（overlay 可达 127GB）  
- 支持 LuCI Web 管理界面  
- 支持 IPv6 / DHCPv6 / SLAAC  
- 支持 PPPoE / DHCP / 静态 IP  
- 支持 VLAN / Bridge / Bonding  
- 支持 Zerotier / Tailscale（可选）

### ✅ 极简设计
- 默认不包含 NAS、USB、Docker、Python 等无关组件  
- 固件体积小、运行稳定  
- 适合纯路由场景

---

## 📦 3. 128GB eMMC 分区布局（SL3000 专用）

SL3000 的 eMMC 容量为 **128GB**，固件采用如下布局：

| 分区 | 大小 | 说明 |
|------|------|------|
| preloader | 2MB | 启动加载器 |
| uboot | 4MB | U-Boot 引导 |
| uboot-env | 512KB | 环境变量 |
| factory | 4MB | WiFi 校准数据 |
| fip | 4MB | ARM Trusted Firmware |
| kernel | 32MB（可调） | 内核镜像 |
| rootfs | 512MB（可调） | 系统根文件系统（只读） |
| **userdata** | **剩余全部空间（约 127GB）** | overlay、软件安装、Docker、日志等 |

### ✅ 重点说明  
- rootfs 是只读的，不需要加大  
- 所有可写内容（软件、配置、Docker）都在 userdata  
- 你的设备拥有 **约 127GB 的超大 overlay 空间**

---

## 🐳 4. Docker 使用说明（重要）

### ✅ Docker 默认使用 userdata（overlay）分区  
路径如下：
