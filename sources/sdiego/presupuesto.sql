SELECT
  periodo,
  categoria,
  importe,
  ejercido,
  diferencia
FROM bronze.gsheets_presupuesto
WHERE periodo IS NOT NULL
