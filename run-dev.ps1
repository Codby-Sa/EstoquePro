Get-Content .env | ForEach-Object {
    if ($_ -match "^\s*#") {
        return
    }

    if ($_ -match "^\s*$") {
        return
    }

    $name, $value = $_.Split("=", 2)

    if ($name -and $value) {
        [System.Environment]::SetEnvironmentVariable($name.Trim(), $value.Trim(), "Process")
    }
}

.\mvnw.cmd spring-boot:run