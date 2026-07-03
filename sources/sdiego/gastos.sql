SELECT
  fecha,
  categoria,
  concepto,
  importe,
  estado
FROM bronze.gsheets_gastos
WHERE fecha IS NOT NULL
