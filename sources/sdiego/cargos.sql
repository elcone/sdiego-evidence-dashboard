SELECT
    casa,
    periodo,
    strftime(periodo, '%Y-%m-%d') as fecha_vencimiento,
    cuota,
    recargos,
    estado,
    vencimiento
FROM bronze.gsheets_cuotas
