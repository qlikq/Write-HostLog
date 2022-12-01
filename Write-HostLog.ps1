function Write-HostLog {
    <#
    .SYNOPSIS
        Outputs message to host that is made from different colors and shows what called the 
        function Write-HostLog.
    .DESCRIPTION
        When using logging to screen in scripts , i want to see which function is currently displaying
        message to the screen, and i want to make sure that i can easily spot about what is it by
        making categories using colors. For now this is just colors.
    .EXAMPLE
        PS C:\> Write-HostLog  write-hostlog -Message '[subsystem]','[function]','Text logged goes here' 
        -Colors lightcyan,white,lightred,lightmagenta
        Write-HostLog::[subsystem]::[function]::Text logged goes here
        This example shows the message using 4 colors, each for different part of the message
    .EXAMPLE
        PS C:\>  write-hostlog -Message '[subsystem]','Text logged goes here' 
        -Colors white,lightred,lightmagenta -divider '**'
        Write-HostLog**[subsystem]**Text logged goes here
        This example shows the message using 3 colors, each for different part of the message and has
        a custom divider part, two stars in this case.
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        Output (if any)
    .NOTES
        Version:        0.1
        Author:         Grzegorz Kulikowski
        Creation Date:  03/02/2020
    #>
    [CmdletBinding()]
    param (
        [parameter(Mandatory=$false,ValueFromPipeline = $false)]
        [string[]]$Message,
        [ForegroundColor[]]$Colors,
        [string]$divider = '::',
        [string]$template,
        [switch]$date
    )
    
    begin {
        enum ForegroundColor {
            godefault = 39
            black = 30
            red = 31
            Green = 32
            yellow = 33
            blue = 34
            magenta = 35
            cyan = 36
            darkgrey = 90
            lightred = 91
            lightblue = 94
            lightmagenta = 95
            lightcyan = 96
            white = 97
        }
        $templates =@{'good'=@('darkgrey','green','lightmagenta');'bad'=@('darkgrey','red','lightred')}
        If ($template) {$colors = $templates[$template]}
        $esc = "$([char]27)"
        $defcolor = $esc+'['+[ForegroundColor]::godefault.value__+'m'
        $PScallStack = (Get-PSCallStack)[1].Command
        $NewMessage = $esc+'['+$colors[0].value__+'m'+$PScallStack+$esc+'['+[ForegroundColor]::godefault.value__+'m'+'::'+$esc+'['+[ForegroundColor]::lightcyan.value__+'m'+$global:DefaultVIServer.name
        if ($date){$NewMessage = $esc+'['+[ForegroundColor]::lightcyan.value__+'m['+(get-date).toString()+'] ' + $NewMessage}
        $i=1
        foreach ($msg in $Message){
            $NewMessage = $NewMessage+$defcolor+ $divider + $esc+'['+$colors[$i].value__+'m'+$msg
            $i++
        }

    }
    
    process {
        
    }
    
    end {
        Write-Host $NewMessage
        write-host 'a'
    }
}
