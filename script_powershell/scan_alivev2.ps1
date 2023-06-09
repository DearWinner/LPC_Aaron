#Realizado por: Aaron Avila Mata
#Matricula: 1998679
#Grupo: 062

#escaneo de equipos activos en la subred

#determinando gateway

$subred = (Get-NetRoute -DestinationPrefix 0.0.0.0/0).NextHop
Write-Host "Determinando tu gateway ..."
Write-Host "Tu gateway es: " $subred

# determinando rango de subred
$rango = $subred.Substring(0, $subred.IndexOf('.') + 1 + $subred.Substring($subred.IndexOf('.') + 1).IndexOf('.') + 4)
Write-Host "Determinando tu rango de subred ..."
Write-Host $rango

#Determinando si rango termina en .

$punto = $rango.EndsWith('.')
if ($punto -like "False"){
    $rango = $rango + '.'
}

# Creamos un array con 254 numeros y se almacenan en una variable
#llamada $rango_ip

$rango_ip = @(1..254)

#Generamos bucle foreach para validad hosts activos en nuestra subred


Write-Output ""
Write-Host "Subred actual: "
Write-Host "Escaneando: " -NoNewline; Write-Host $rango -NoNewline; Write-Host "0/24" -ForegroundColor Green
foreach ($r in $rango_ip){
    $actual = $rango + $r # se genera direccion ip
    $responde = Test-Connection $actual -Quiet -Count 1
    if ($responde -eq "True"){
        Write-Output ""
        Write-Host "Host responde: " -NoNewline; Write-Host $actual -ForegroundColor Green
    }
}

# fin script
