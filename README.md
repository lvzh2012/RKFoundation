# RKFoundation

一个使用 Swift Package Manager 分发的 iOS 框架。

## 安装

### 使用 Swift Package Manager

在 Xcode 中：
1. 选择 File > Add Packages...
2. 输入此仓库的 URL
3. 选择版本或分支
4. 添加到你的项目

### 使用本地路径

如果你在本地开发，可以直接在 Xcode 中添加本地包路径。

## 发布新版本

### 方法一：使用自动化脚本（推荐）

1. 运行发布脚本：
```bash
./release.sh 1.0.0
```

2. 按照脚本提示创建 GitHub Release：
   - 访问：`https://github.com/YOUR_USERNAME/YOUR_REPO/releases/new`
   - 创建标签：`v1.0.0`
   - 上传 `RKFoundation.xcframework.zip` 文件

3. 自动更新 Package.swift：
```bash
./update-package-url.sh YOUR_USERNAME YOUR_REPO 1.0.0
```

### 方法二：手动操作

1. 确保 `RKFoundation.xcframework` 目录存在

2. 生成 zip 和 checksum：
```bash
./generate-checksum.sh
```

3. 创建 GitHub Release：
   - 访问 GitHub 仓库的 Releases 页面
   - 点击 "Create a new release"
   - 输入标签（如 `v1.0.0`）和版本标题
   - 上传 `RKFoundation.xcframework.zip` 文件
   - 发布后，zip 文件的 URL 格式为：
     ```
     https://github.com/USERNAME/REPO/releases/download/v1.0.0/RKFoundation.xcframework.zip
     ```

4. 更新 `Package.swift`：
   - 将 `url` 替换为实际的 GitHub Release URL
   - 将 `checksum` 替换为生成的 checksum 值

### 其他托管方式

如果你不使用 GitHub Releases，可以：
- 使用 GitLab Releases
- 使用自己的服务器/CDN
- 使用其他静态文件托管服务

URL 格式需要是直接可下载的链接，Swift Package Manager 会验证 checksum 来确保文件完整性。

## 要求

- iOS 13.0 或更高版本
- Swift 5.9 或更高版本
- Xcode 15.0 或更高版本

## 使用

```swift
import RKFoundation

// 使用框架中的功能
```

