# スクリプトについて

このスクリプトは Windows OS の設定情報を採取する PowerShell スクリプトです。

スクリプトの実行開始から終了まで、おおよそ 10 ～ 30 分程度の時間がかかります。
なお、ご使用の環境により時間は異なります。

# 使用方法

## コマンドプロンプトで実行する場合

**管理者権限**でコマンドプロンプトを起動します。

> [!WARNING]
> 管理者権限で起動しなかった場合、スクリプトは実行されますが、一部のパラメーターが採取できません。

スクリプトがあるフォルダに移動します。

```
cd <展開したフォルダパス>
```

スクリプトを実行します。
実行結果は`OUTPUT`フォルダに出力されます。

```
powershell .\windump.ps1
```

# 採取する情報

| 項目                       | 内容                                                   | 出力ファイル名                                      |
| -------------------------- | ------------------------------------------------------ | --------------------------------------------------- |
| システム情報               | `systeminfo`の実行結果                                 | `system\systeminfo.log`                             |
| 環境変数                   | `Get-ChildItem env:`の実行結果                         | `system\gci_env.csv`                                |
| OS ライセンス認証          | `slmgr /dli`の実行結果                                 | `system\os_license_status.log`                      |
| サービス情報               | `Get-Service`の実行結果                                | `system\Service.csv`                                |
| デバイス情報               | `Get-WmiObject -class Win32_PnPEntity`の実行結果       | `system\DeviceInfo_PnPEntity.csv`                   |
| デバイス情報               | `Get-WmiObject -class Win32_PnPSignedDriver`の実行結果 | `system\DeviceInfo_PnPSignedDriver.csv`             |
| レジストリ情報             | `reg query`で取得したレジストリ情報                    | `system\registry_***.log`                           |
| ディスク情報               | `Get-Disk`, `Get-PhysicalDisk`の実行結果               | `system\Get-Disk.csv` `system\Get-PhysicalDisk.csv` |
| ネットワーク情報           | ネットワーク設定、ネットワークデバイス情報             | `network\*`                                         |
| ネットワークチーミング情報 | チーミング設定情報                                     | `network_team\*`                                    |

> [!NOTE]
> チーミングされたネットワークデバイスが存在しない場合、ネットワークチーミング情報には`No_TeamingDevices`ファイルが生成されます。

# 開発者情報

komoto

# ライセンス

MIT ライセンスに基づいて配布されます。
詳細については、`LICENSE`を参照してください。
