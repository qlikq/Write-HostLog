Describe "Write-HostLog Tests" {
    AfterEach {

    }
 
    Context "General tests" {

       It '1=1' {
        #Arrange
          # Act
          # Assert
          1 | Should -be 1
       }
 

 
    Context "Additional test" {
       It 'Checking if there was output on console' {
        {write-hostlog -message "aaa" -colors 'blue'} | should -not -Throw
       }
       It 'Checking if there was error thrown' {
        {write-hostlog -message "aaa"} | should -Throw
       }
    }
 }
}