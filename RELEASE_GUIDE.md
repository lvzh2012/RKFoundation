# 发布指南：如何生成 Zip URL

本指南详细说明如何为 Swift Package Manager 生成 zip URL。

## 快速开始

最简单的方式是使用提供的自动化脚本：

```bash
# 1. 准备发布包（生成 zip 和 checksum）
./release.sh 1.0.0

# 2. 按照提示创建 GitHub Release 并上传 zip 文件

# 3. 自动更新 Package.swift
./update-package-url.sh YOUR_USERNAME YOUR_REPO 1.0.0
```

## 详细步骤

### 方式一：GitHub Releases（推荐）

#### 步骤 1：准备发布文件

```bash
./release.sh 1.0.0
```

这会：
- 创建 `RKFoundation.xcframework.zip`
- 生成 SHA256 checksum
- 显示发布信息

#### 步骤 2：创建 GitHub Release

1. 访问你的 GitHub 仓库
2. 点击 "Releases" → "Create a new release"
3. 填写信息：
   - **Tag**: `v1.0.0`（必须以 `v` 开头）
   - **Title**: `Release 1.0.0`
   - **Description**: 版本说明
4. 上传 `RKFoundation.xcframework.zip` 文件
5. 点击 "Publish release"

#### 步骤 3：获取 URL

发布后，zip 文件的 URL 格式为：
```
https://github.com/USERNAME/REPO/releases/download/v1.0.0/RKFoundation.xcframework.zip
```

例如：
```
https://github.com/apple/swift-nio/releases/download/2.0.0/MyFramework.xcframework.zip
```

#### 步骤 4：更新 Package.swift

手动更新或使用脚本：

```bash
./update-package-url.sh YOUR_USERNAME YOUR_REPO 1.0.0
```

### 方式二：使用 GitLab Releases

GitLab Releases 的 URL 格式类似：

```
https://gitlab.com/USERNAME/REPO/-/releases/v1.0.0/downloads/RKFoundation.xcframework.zip
```

### 方式三：使用自定义服务器/CDN

如果你有自己的服务器或 CDN：

1. 将 `RKFoundation.xcframework.zip` 上传到服务器
2. 确保文件可以通过 HTTPS 直接访问
3. 使用完整的 URL，例如：
   ```
   https://cdn.example.com/releases/RKFoundation-1.0.0.xcframework.zip
   ```

### 方式四：使用 GitHub Raw Content（不推荐）

虽然技术上可行，但不推荐使用 GitHub raw content，因为：
- URL 可能不稳定
- 没有版本控制
- 可能触发 GitHub 的速率限制

如果必须使用，URL 格式为：
```
https://raw.githubusercontent.com/USERNAME/REPO/BRANCH/path/to/file.zip
```

## URL 要求

Swift Package Manager 对 zip URL 的要求：

1. ✅ 必须是 HTTPS 协议
2. ✅ 必须可以直接下载（不需要认证）
3. ✅ 文件必须是有效的 zip 格式
4. ✅ 解压后必须包含 `.xcframework` 目录
5. ✅ checksum 必须匹配

## 验证

更新 `Package.swift` 后，可以验证配置：

```bash
swift package resolve
```

如果 URL 或 checksum 不正确，会显示错误信息。

## 常见问题

### Q: 如何更新版本？

A: 重复发布流程，使用新的版本号：
```bash
./release.sh 1.1.0
# 创建新的 GitHub Release
./update-package-url.sh YOUR_USERNAME YOUR_REPO 1.1.0
```

### Q: 可以同时支持多个版本吗？

A: 可以。每个版本对应一个 GitHub Release，用户可以在 Xcode 中选择特定版本。

### Q: checksum 不匹配怎么办？

A: 确保：
1. zip 文件没有被修改
2. 使用正确的 checksum（运行 `./generate-checksum.sh` 重新生成）
3. Package.swift 中的 checksum 没有多余的空格或换行

### Q: 可以使用本地文件路径吗？

A: 可以，但不推荐用于分发。如果只是本地开发，可以在 `Package.swift` 中使用：
```swift
.binaryTarget(
    name: "RKFoundation",
    path: "RKFoundation.xcframework"
)
```

## 示例

完整的发布流程示例：

```bash
# 1. 准备 1.0.0 版本
./release.sh 1.0.0

# 输出：
# Version:     1.0.0
# Zip File:    RKFoundation.xcframework.zip (57K)
# Checksum:    48db0bfc2b0afef21335e35ff17c8cad6a379ec4776bbec0127ceb0b9e5bc770

# 2. 在 GitHub 创建 Release v1.0.0，上传 zip 文件

# 3. 更新 Package.swift
./update-package-url.sh myusername RKFoundation 1.0.0

# Package.swift 现在包含：
# url: "https://github.com/myusername/RKFoundation/releases/download/v1.0.0/RKFoundation.xcframework.zip"
# checksum: "48db0bfc2b0afef21335e35ff17c8cad6a379ec4776bbec0127ceb0b9e5bc770"
```

