#!/bin/bash


# This programm is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.

# Backup-Script für einfache Sicherung mit tar z.B. auf eine externe Platte

#Ausführung
#Für Full-Backup: backup.sh -f
#Für differentielles Backup: backup.sh -d

# 1. Variable für aktuelles Datum um es später als Dateiname schreiben zu lassen

DATE=$(date -I)

# 2. Orte an die die jeweiligen Dateien gesichert werden sollen. Die eindeutige Platten ID kann z.B. über "lsblk" ausgelesen werden

dest_dir="/media/user/eindeutigePlattenID"

# 3. Die Dateien, die gesichert werden sollen. 

source_dir="/home/user"

# 4. Backup Verzeichnisse erstellen, wenn gewünscht Auskommentierung entfernen

#if [ ! -d $dest_dir ];then # Wenn -directory dest_dir nicht existiert, dann erstelle es
#					mkdir -p $dest_dir
#		fi



# 5. While-Case mit Aufruf des Kommandos getopts. Das getopts stellt die Optionen -f und -d für das Skript zur Verfügung.
#    Wenn $OPTION den Wert f hat, wird ein Full-Backup ausgeführt. Bei d ein differentielles.
#    Full-Backup mit tar: Erstellen der tar Archive mit $dest_dir als Zielort und $source_dir als Quellort. Dateinamen aus $DATE und -full.

while getopts fd OPTION ;
	do
	case "$OPTION" 
	in
	f) tar --exclude='/home/user/VirtualBox VMs/Debian' --exclude='/home/user/VirtualBox VMs/zabbix*' -cpf $dest_dir/'backup-full'.tar --totals --verbose $source_dir;;

	d) tar --exclude='/home/user/VirtualBox VMs/Debian' --exclude='/home/user/VirtualBox VMs/zabbix*' -cpf $dest_dir/$DATE'-diff'.tar -N $dest_dir/'backup-full'.tar --totals --verbose $source_dir
	esac
	echo " "
	echo "Auf Backup vorhandene Ordner und Dateien":
	echo " "
	ls -la /media/user/eindeutigePlattenID
done

# While-Case ist abgeschlossen.

