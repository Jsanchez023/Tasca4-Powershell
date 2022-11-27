# Genera un script que permeti enviar un correu per gmail quan finalitzi la còpia d'uns fitxers. Pots reutilitzar el codi que vas utilitzar per fer les còpies de segureta per tal que al finalitzar enviï un correu de confirmació.
$credenciales = Get-Credential
$correo = Read-Host -Prompt "Introdueix el correu en el qual es rebrà el avis"
while( 1 -eq 1){ #Crea un bucle per recorrer el programa un alre cop en cas d'error en la ruta
clear; $ruta = Read-Host -Prompt 'Introdueix la ruta del arxiu a copiar'  #demana la ruta per guardarla en  una variable
$copia = Read-Host -Prompt 'Introdueix la ruta on es guardara la copia'   #demana la ruta on copiar l'arxiu i la guarda en una variable
Copy-Item $ruta -Destination $copia -ErrorAction SilentlyContinue  #copia l'arxiu a la ruta especificada 
if($? -eq "true"){   # si s'ha realitzat la copia satisfactoriament trenca el bucle
"S'ha realitzat la copia satisfactoriament"
 Send-MailMessage -From $correo -To $correo -UseSsl -Subject 'Copia de seguretat' -Body "La copia de seguretat s'ha realitzat correctament" -SmtpServer 'smtp.gmail.com' -Port '587' -Credential $credenciales
break
}
else{
"La ruta del fitxer o del desti no existeix"
sleep 2  #espera 2 segons per poder veure el misatje anterior
}
}