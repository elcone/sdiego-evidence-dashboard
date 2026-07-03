SELECT
  periodo,
  cast(casa AS VARCHAR) AS casa,
  cuota,
  recargos,
  pagos,
  saldo,
  estado,
  fecha_pago,
  importe_recaudado
FROM bronze.gsheets_cuotas
WHERE periodo IS NOT NULL
