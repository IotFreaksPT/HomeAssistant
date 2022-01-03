# Home Assistant Grafana Energy

## config.yaml

Adicionar a entrada para o influxdb se não disponivel. Se estiverem a usar a tag include, podem usar o padrão apresentado:

```yaml
include:
  entity_globs:
    - "sensor.energy_*_usage"
```

## influxdb.sql

Fazer Login no influxdb e executar os comandos. Caso já tenha a base de dados criada, ocultar o `CREATE DATA BASE`.

Se pretederem um nome diferente para a base de dados, devem alterar em todos os comandos e igualmente no config.yaml.

## package/energy.yaml

Decaração das regras:

- automation utility_meter_tariff: delclaração do horario de vazio (offpeak) e ponta (peak)
- utility_meter: declaração dos meters para capturar os consumos
- input_number energy_price_daily: preço da tarifa diaria
- input_number energy_price_peak: preço do kwh em ponta (centimos)
- energy_price_offpeak: preço do kwh no vazio (centimos)
