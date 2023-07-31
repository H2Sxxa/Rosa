# 下载 🔗

## 说明

当 Gradle 检测到需要的 JDK 版本与当前 JDK 版本不匹配时会自动下载一个JDK，通常为了避免网络问题，我们会将 JAVA_HOME 指向特定的 JDK。

但对于 MCreator 不会使用环境变量里的 JAVA_HOME，而是需要 Gradle 下载一个 JDK 供 ForgeGradle 使用，这导致了网络问题的出现，因此，好做法是提前下好 JDK 放在 `.mcreator/gradle/jdks` 中。

**⚠ 注意： MCreator用户请先前往设置将使用MCreator改为`是`**

JDK 8  （适用于 Minecraft 1.16.5 或更旧版本）
JDK 16 （适用于 Minecraft 1.17.x）
JDK 17 （适用于 Minecraft 1.18 或更新版本）

勾选你需要的JDK再点击下方按钮等待弹窗反馈即可.

---
