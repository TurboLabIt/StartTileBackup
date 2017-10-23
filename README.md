#StartTileBackup
A simple batch script to backup and restore the Start menu tiles. Requires at least Windows 10 Fall Creators Update.

**Parli italiano?** » Leggi: [Menu Start: come creare un backup dei Riquadri animati (Live Tiles) di Windows 10 Fall Creators Update (1709)](https://turbolab.it/1241)

![spotlight](https://turbolab.it/immagini/med/guida-windows-10-menu-start-dove-sono-salvati-come-creare-backup-riquadri-animati-live-tiles-partendo-tiledatalayer-backup-start-menu-windows-10-8390.img)


#Backup
Run `Backup.bat` as administrator to backup the current tiles. The backup files are dumped in the `backup/` directory inside the script directory, overwriting every previous backup copy.


#Restore
Run `Restore.bat` as administrator to restore the last backup.
