Attribute VB_Name = "Module1"
Sub Stock_Data()
Dim ws As Worksheet
For Each ws In ThisWorkbook.Worksheets
    output_row = 2
    volume_total = 0
    lastRow = Cells(Rows.Count, 1).End(xlUp).Row
    
    'Total
Cells(1, 9).Value = "Ticker"
Cells(1, 10).Value = "Year Change"
Cells(1, 11).Value = "Percent Change"
Cells(1, 12).Value = "Total Volume"
For input_row = 2 To lastRow
    If Cells(input_row + 1, 1).Value <> Cells(input_row, 1).Value Then
      Cells(output_row, 9).Value = Cells(input_row, 1).Value
      volume_total = volume_total + Cells(input_row, 7).Value
      Cells(output_row, 12).Value = volume_total
      output_row = output_row + 1
      volume_total = 0
    Else
      volume_total = volume_total + Cells(input_row, 7).Value
    End If
    'yearly change
    closing_data = Cells(input_row, 6).Value
    opening_data = Cells(input_row, 3).Value
    yearly_change = closing_data - opening_data
    If Cells(input_row + 1, 1).Value <> Cells(input_row, 1).Value Then
        Cells(output_row, 10).Value = yearly_change
        yearly_change = 0
    Else
    yearly_change = yearly_change - opening_data
        End If
    'color formatting
    If Cells(output_row, 10) < 0 Then
        Cells(output_row, 10).Interior.ColorIndex = 3
    ElseIf Cells(output_row, 10) > 0 Then
        Cells(output_row, 10).Interior.ColorIndex = 4
       
    End If
    ' percent change
    If Cells(output_row, 3).Value <> 0 Then
        percent_change = ((Cells(input_row, 6).Value - Cells(output_row, 3).Value) / Cells(output_row, 3).Value)
        Cells(output_row, 11).Value = Format(percent_change, "Percent")
    Else
        Cells(output_row, 11).Value = Format(0, "Percent")
    End If


Next input_row
Cells(4, 15).Value = "Greatest Volume"
Cells(5, 15).Value = "Greatest Increase"
Cells(6, 15).Value = "Greatest Decrease"

Cells(4, 16) = Application.WorksheetFunction.Max(Range("L:L"))
Cells(5, 16) = Application.WorksheetFunction.Max(Range("K:K"))
Cells(6, 16) = Application.WorksheetFunction.Min(Range("K:K"))
Next ws
End Sub
