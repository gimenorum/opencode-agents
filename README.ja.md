# OpenCode Agents

OpenCode Goの利用者向けのサブエージェント設定が含まれています。

## 含まれているもの

- `opencode.jsonc`: プロジェクト向けのOpenCode設定
- `setup.sh`: 対象プロジェクトへ設定を展開するインストーラ
- `.opencode/agents/*.md`: 探索、調査、レビュー、実装、設計代替用のサブエージェント定義

## 目的

このリポジトリは、OpenCodeの設定やサブエージェント定義を複数のプロジェクトで再利用するためのテンプレートを提供します。

## インストール方法

### macOS/Linux

```bash
curl -fsSL https://raw.githubusercontent.com/gimenorum/opencode-agents/main/setup.sh | bash
```

特定のディレクトリにインストールしたい場合

```bash
curl -fsSL <URL> | bash -s <YourDirectory>
```

### Windows

#### powershell

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "$script = (Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/gimenorum/opencode-agents/main/setup.ps1').Content; & ([scriptblock]::Create($script))"
```

特定のディレクトリにインストールしたい場合

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "$script = (Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/gimenorum/opencode-agents/main/setup.ps1').Content; & ([scriptblock]::Create($script)) -Destination '<YourDirectory>'"
```

#### cmd

```bat
powershell -NoProfile -ExecutionPolicy Bypass -Command "$script = (Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/gimenorum/opencode-agents/main/setup.ps1').Content; & ([scriptblock]::Create($script))"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$script = (Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/gimenorum/opencode-agents/main/setup.ps1').Content; & ([scriptblock]::Create($script)) -Destination '<YourDirectory>'"
```

このスクリプトは`FILES`に定義されたファイルを取得し、対象ディレクトリへコピーします。既存の同名ファイルは上書きされますが、他のファイルはそのまま保持されます。

## 含まれるエージェント

- `explore`: コードベースの探索と構造把握
- `scout`: 外部ドキュメントや依存ライブラリの調査
- `review`: セキュリティ、性能、保守性、エッジケースを重視したコードレビュー
- `general`: 複数ステップの実装作業を担当する汎用エージェント
- `design-fallback`: 利用枠制限時の設計専用フォールバック

## ライセンス

このプロジェクトは MIT License のもとで公開しています。

全文は [LICENSE](LICENSE) を参照してください。
