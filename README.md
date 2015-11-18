# HulkImport
Tool for easily importing CSV data into SQL Server

Creates the values statement of a SQL insert statement.

## Install
Install and set up [stack](https://github.com/commercialhaskell/stack)


```
stack install HulkImport
```

## Usage

Run like this

```
HulkImport-exe -i 'data.csv' -o 'values.sql'
```
