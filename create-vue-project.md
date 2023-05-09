## 官方cli创建项目
npm init vue@latest

## 使用最新版本node
项目中创建 .nvmrc 文件，内容为最新版本号，如：v18.16.0

nvm use 切换到当前项目的node版本，会自动使用 .nvmrc 文件中的版本

## 切换淘宝镜像
项目中创建 .npmrc 文件，内容为：
``` .npmrc
registry=http://registry.npmmirror.com
```

## 安装 pnpm
npm install -g pnpm

## 限制项目只能使用 pnpm 安装依赖
package.json 中添加
``` json
{
  "scripts": {
    "preinstall": "npx only-allow pnpm",
  },
}
```

## 安装依赖
pnpm install

## 重启 vscode
tsconfig.json 中的配置可能会报错，重启 vscode 即可

记得 *nvm use* 切换到当前项目的node版本

## 启动项目
pnpm run dev

## 锁定项目node版本

我使用了ts，脚本也用ts写，运行ts脚本需要 ts-node

pnpm install -D ts-node

tsconfig.json 中添加

``` json
{
  "ts-node": {
    "extends": "@vue/tsconfig/tsconfig.node.json",
    "compilerOptions": {
      "module": "NodeNext",
      "moduleResolution": "Node",
      "target": "ESNext",
      "resolveJsonModule": true,
      "isolatedModules": true,
      "types": ["node"]
    }
  },
}
```

.npmrc 中添加

``` yaml
engine-strict=true
enable-pre-post-scripts=true
```

package.json 中添加

``` json
{
  "scripts": {
    "check-versions": "ts-node ./scripts/check-versions.ts",
    "predev": "pnpm run check-versions",
    "prebuild": "pnpm run check-versions",
  },
  "engines": {
    "node": "18.16.0",
    "pnpm": "8.4.0"
  }
}
```

*./scripts/check-versions.ts*

``` ts
/* eslint-env node */
import fs from 'fs'

console.log('Checking node versions...')

// 当前node版本
console.log('Current node version:', process.version)

// 从.nvmrc文件中读取node版本
const nvmrc = fs.readFileSync('.nvmrc', 'utf8').trim()
console.log('Node version in .nvmrc:', nvmrc)

if (nvmrc !== process.version) {
  console.error('Node version in .nvmrc does not match current version')
  process.exit(1)
}

export {}
```

## eslint 配置

修改 .eslintrc.js

``` js
{
 extends: [
  'plugin:vue/vue3-strongly-recommended', // 修改为强烈推荐的规则
 ]
}
```

## 根据喜好配置 prettier

``` json
{
  "$schema": "https://json.schemastore.org/prettierrc",
  "semi": false,
  "tabWidth": 2,
  "singleQuote": true,
  "printWidth": 100,
  "trailingComma": "none",
  "bracketSameLine": true,
  "htmlWhitespaceSensitivity": "ignore"
}
```

## 初始化git仓库

git init

## 安装 husky

[https://juejin.cn/post/7073381754777632775](https://juejin.cn/post/7073381754777632775)

## 代码提交前 检查ts类型

.pre-commit 文件中添加

``` sh
pnpm run type-check
```

## 安装nodemon

pnpm install -D nodemon

package.json 中添加

``` json
{
  "scripts": {
    "dev:watch": "nodemon ",
  },
}
```

nodemon.json 中添加

``` json
{
  "ignore": ["node_modules", "dist"],
  "exec": "npm run dev",
  "watch": [
    "public/**",
    "!public/version.txt",
    "*.config.js",
    "*.config.ts",
    ".eslint**.*",
    "package.json",
    "index.html"
  ]
}
```

## 及时检查ts类型

pnpm install -D vite-plugin-checker

vite.config.ts 中添加

``` ts
export default defineConfig({
  plugins: [
    checker({ vueTsc: true }),
  ],
})
```

## 自动lint fix

pnpm i -D vite-plugin-eslint

vite.config.ts 中添加

``` ts
export default defineConfig({
  plugins: [
    eslint({ 
      cache: false,
      fix: true,
    })
  ],
})
```

## 常用包自动导入 

pnpm i -D unplugin-auto-import

vite.config.ts 中添加

``` ts
export default defineConfig({
  plugins: [
    AutoImport({
      imports: [
        'vue',
        'vue-router',
        'vuex',
      ],
      vueTemplate: true,
      dts: './auto-imports.d.ts',
    }),
  ],
})
```

tsconfig.json 中添加

``` json
{
  "include": [
    "...",
    "auto-imports.d.ts"
  ]
}
```

如果不生效，禁用vscode 自带的ts插件，仅使用volar插件检查ts类型

ctrl + shift + p -> 搜索 show builtin extensions -> 禁用 TypeScript and JavaScript Language Features

重启vscode
