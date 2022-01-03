# Home Assistant Grafana Energy

## Exemplo

![image](https://user-images.githubusercontent.com/11949987/147956276-d9e8d159-b3f3-435c-95e0-852632683c62.png)
![image](https://user-images.githubusercontent.com/11949987/147956289-a3d163c5-bed9-4118-b726-9a3dfe052b0c.png)
![image](https://user-images.githubusercontent.com/11949987/147956303-cbb098a0-f55f-4cd4-b9e3-b8ac30a521db.png)
![image](https://user-images.githubusercontent.com/11949987/147956341-e1666e2a-1b8d-4bd9-8b42-29447e63c1cd.png)


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
