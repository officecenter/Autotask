---
external help file: Autotask-help.xml
Module Name: Autotask
online version:
schema: 2.0.0
---

# New-AtwsChangeOrderCost

## SYNOPSIS
This function creates a new ChangeOrderCost through the Autotask Web Services API.
All required properties are marked as required parameters to assist you on the command line.

## SYNTAX

### By_parameters (Default)
```
New-AtwsChangeOrderCost [-AllocationCodeID <Int32>] [-BillableAmount <Decimal>] [-BillableToAccount <Boolean>]
 [-Billed <Boolean>] [-BusinessDivisionSubdivisionID <Int32>] [-ChangeOrderHours <Decimal>]
 [-ContractServiceBundleID <Int32>] [-ContractServiceID <Int32>] -CostType <String> [-CreateDate <DateTime>]
 [-CreatorResourceID <Int32>] -DatePurchased <DateTime> [-Description <String>] [-ExtendedCost <Decimal>]
 [-InternalCurrencyBillableAmount <Decimal>] [-InternalCurrencyUnitPrice <Decimal>]
 [-InternalPurchaseOrderNumber <String>] -Name <String> [-Notes <String>] [-ProductID <Int32>]
 [-PurchaseOrderNumber <String>] [-Status <String>] [-StatusLastModifiedBy <Int32>]
 [-StatusLastModifiedDate <DateTime>] -TaskID <Int32> [-UnitCost <Decimal>] [-UnitPrice <Decimal>]
 [-UnitQuantity <Decimal>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Input_Object
```
New-AtwsChangeOrderCost [-InputObject <ChangeOrderCost[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The function supports all properties of an \[Autotask.ChangeOrderCost\] that can be updated through the Web Services API.
The function uses PowerShell parameter validation  and supports IntelliSense for selecting picklist values.
Any required paramterer is marked as Mandatory in the PowerShell function to assist you on the command line.

If you need very complicated queries you can write a filter directly and pass it using the -Filter parameter.
To get the ChangeOrderCost with Id number 0 you could write 'New-AtwsChangeOrderCost -Id 0' or you could write 'New-AtwsChangeOrderCost -Filter {Id -eq 0}.

'New-AtwsChangeOrderCost -Id 0,4' could be written as 'New-AtwsChangeOrderCost -Filter {id -eq 0 -or id -eq 4}'.
For simple queries you can see that using parameters is much easier than the -Filter option.
But the -Filter option supports an arbitrary sequence of most operators (-eq, -ne, -gt, -ge, -lt, -le, -and, -or, -beginswith, -endswith, -contains, -like, -notlike, -soundslike, -isnotnull, -isnull, -isthisday).
As you can group them using parenthesis '()' you can write arbitrarily complex queries with -Filter. 

To create a new ChangeOrderCost you need the following required fields:
 -CostType
 -DatePurchased
 -Name
 -TaskID

Entities that have fields that refer to the base entity of this CmdLet:

## EXAMPLES

### EXAMPLE 1
```
$result = New-AtwsChangeOrderCost -CostType [Value] -DatePurchased [Value] -Name [Value] -TaskID [Value]
Creates a new [Autotask.ChangeOrderCost] through the Web Services API and returns the new object.
```

### EXAMPLE 2
```
$result = Get-AtwsChangeOrderCost -Id 124 | New-AtwsChangeOrderCost 
Copies [Autotask.ChangeOrderCost] by Id 124 to a new object through the Web Services API and returns the new object.
```

### EXAMPLE 3
```
Copies [Autotask.ChangeOrderCost] by Id 124 to a new object through the Web Services API, passes the new object to the Set-AtwsChangeOrderCost to modify the object.
```

### EXAMPLE 4
```
-Passthru
Copies [Autotask.ChangeOrderCost] by Id 124 to a new object through the Web Services API, passes the new object to the Set-AtwsChangeOrderCost to modify the object and returns the new object.
```

## PARAMETERS

### -InputObject
An array of objects to create

```yaml
Type: ChangeOrderCost[]
Parameter Sets: Input_Object
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -AllocationCodeID
Allocation Code ID

```yaml
Type: Int32
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -BillableAmount
Billable Amount

```yaml
Type: Decimal
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -BillableToAccount
Billable To Account

```yaml
Type: Boolean
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Billed
Billed

```yaml
Type: Boolean
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -BusinessDivisionSubdivisionID
Business Division Subdivision ID

```yaml
Type: Int32
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ChangeOrderHours
Change Order Hours

```yaml
Type: Decimal
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContractServiceBundleID
Contract Service Bundle ID

```yaml
Type: Int32
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContractServiceID
Contract Service ID

```yaml
Type: Int32
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -CostType
Cost Type

```yaml
Type: String
Parameter Sets: By_parameters
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CreateDate
Create Date

```yaml
Type: DateTime
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CreatorResourceID
Creator Resource ID

```yaml
Type: Int32
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -DatePurchased
Date Purchased

```yaml
Type: DateTime
Parameter Sets: By_parameters
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Description

```yaml
Type: String
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExtendedCost
Extended Cost

```yaml
Type: Decimal
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -InternalCurrencyBillableAmount
Internal Currency Billable Amount

```yaml
Type: Decimal
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -InternalCurrencyUnitPrice
Internal Currency Unit Price

```yaml
Type: Decimal
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -InternalPurchaseOrderNumber
Internal Purchase Order Number

```yaml
Type: String
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name

```yaml
Type: String
Parameter Sets: By_parameters
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Notes
Notes

```yaml
Type: String
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProductID
Product ID

```yaml
Type: Int32
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -PurchaseOrderNumber
Purchase Order Number

```yaml
Type: String
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status
Status

```yaml
Type: String
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StatusLastModifiedBy
Status Last Modified By

```yaml
Type: Int32
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -StatusLastModifiedDate
Status Last Modified Date

```yaml
Type: DateTime
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TaskID
Task ID

```yaml
Type: Int32
Parameter Sets: By_parameters
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -UnitCost
Unit Cost

```yaml
Type: Decimal
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -UnitPrice
Unit Price

```yaml
Type: Decimal
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -UnitQuantity
Unit Quantity

```yaml
Type: Decimal
Parameter Sets: By_parameters
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Nothing. This function only takes parameters.
## OUTPUTS

### [Autotask.ChangeOrderCost]. This function outputs the Autotask.ChangeOrderCost that was created by the API.
## NOTES
Related commands:
Remove-AtwsChangeOrderCost
 Get-AtwsChangeOrderCost
 Set-AtwsChangeOrderCost

## RELATED LINKS
