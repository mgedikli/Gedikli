*&---------------------------------------------------------------------*
*& Report ZMG_ALV_200U8
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_alv_200u8_inc.
*Alıştırma – 8: Yeni bir rapor oluşturun ve kullanıcıdan 1 adet CARRID alın. Alınan CARRID ile SCARR
*tablosunu okuyun ve oluşan internal tablonun ALV’sini gösterin. ALV’deki CARRID kolonu HOTSPOT
*olsun. Tıklandığında mevcut ALV’den çıkmadan SPFLI tablosunda ayni CARRID verisine sahip satırların
*ALV’si gösterilsin. (Küçük pencere şeklinde.) Bu ALV’nin de CARRID kolonu HOTSPOT olsun.
*Tıklandığında mevcut ALV’den çıkmadan SFLIGHT tablosunda ayni CARRID verisine sahip satırların
*ALV’si gösterilsin.
*
*S.200-Übung-8:Erstellen Sie einen neuen Bericht und fordern Sie den Benutzer auf, 1 CARRID zu geben.
*Lesen Sie die SCARR-Tabelle mit dem erhaltenen CARRID und zeigen Sie das ALV der entstandenen internen Tabelle an.
*Die CARRID-Spalte im ALV soll ein HOTSPOT sein. Wenn darauf geklickt wird,
*soll das ALV der Zeilen in der SPFLI-Tabelle angezeigt werden, die denselben CARRID-Datensatz haben,
*ohne das aktuelle ALV zu verlassen. Dieses ALV soll auch eine HOTSPOT-Spalte für CARRID haben. Wenn darauf geklickt wird,
*sollen die Zeilen im SFLIGHT-Datensatz angezeigt werden, die denselben CARRID-Datensatz haben, ohne das aktuelle ALV zu verlassen.

INCLUDE ZMG_ALV_200U8_INC_top.
INCLUDE ZMG_ALV_200U8_INC_f01.

START-OF-SELECTION.

  PERFORM select_data.
  PERFORM fcat.
  PERFORM layout.
  PERFORM show_alv.
