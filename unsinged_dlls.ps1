#
#
#    Given a process name the script enumerate all dlls and return as output those unsigned plus Md5
#    The output is saved on a .txt file in same directory of the script
#
#


$curDir =Get-Location      


function unsigned_dlls{

$total=0;
$index=1;


$procName=Read-Host "Process Name";

$output_file=$curDir.Path + "\$procName.txt"

if($procName -eq $null){Write-output "Usage: unsigned_dlls <explorer>" ; Exit }



$dlls=@(Get-Process $procName | select -ExpandProperty modules)
$total=$dlls.count;


if($dlls -eq $null){ Exit }


for($index; $index -lt $total; $index++ ){

    $signed=Get-AuthenticodeSignature -FilePath $dlls[$index].FileName;


    if( $signed.Status -ne "Valid"){


         $file = Get-fileHash -algorithm MD5 $dlls[$index].FileName;

         $padding=80-($file.Path.Length); if($appender -le 0){$appender=80}

         
         $result=$file.Path + "-"*$padding + " MD5>  " + ($file.Hash).ToLower();

         Out-File -FilePath $output_file -Append -InputObject $result
         Write-Output $result 

      
}

}
}
#---------------------------------UNSIGNED DLLS MAIN---------------------------------------------------------------------------

unsigned_dlls


Read-Host "`n`n-----------------  ↵ To Terminate --------------------------"


