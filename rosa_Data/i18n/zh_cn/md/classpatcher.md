# 镜像修补 🩹

## 这是什么？

我们对各个版本的ForgeGradle与RetroFutraGradle的一些类使用jbytemod进行了常量修改，将mojang的maven与asset地址替换为了mcbbs的地址，以此来加速构建。

感谢[**cdc12345**](https://github.com/cdc12345)对本功能开发提供的帮助。

## 注意 ⚠

目前由国内开发者提供的镜像如 `Lss233's Mirror();` \ `BMCLAPI` 都没有及时同步 `Maven` \ `metadata` ，这导致了较高版本的MC会找不到相应依赖（具体可能只支持2022之前的版本），之后会不会更新也说不准，如果使用此功能导致你无法构建，请删除 `.gradle/caches/jars-9` 和 `.gradle/caches/modules-2` 然后重试。

## MCreator

本功能也对MCreator进行了兼容，前往设置，将使用mcreator设置为是即可。

## 计划支持的版本

- RFG
- FG60 （Stable后）
- FG50
- FG40
- FG30
- FG23

---
