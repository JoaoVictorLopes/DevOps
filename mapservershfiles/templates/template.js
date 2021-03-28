// MapServer Template
[resultset layer=layer_municipios]
{
	"type": "FeatureCollection",
	"features": [
		[feature trimlast=","]
		{
			"type": "Feature",
			"id": "[lrn]",
			"layer": "[cl]",
			"geometry": {
				"type": "Polygon",
				"coordinates": "[shpxy precision=2 xh=( yf=)]"
			},
			"properties": {
				"CD_MUN": "[CD_MUN]",
				"NM_MUN": "[NM_MUN]",
				"SIGLA_UF": "[SIGLA_UF]",
				"AREA_KM2": "[AREA_KM2]"
			}
		},
		[/feature]
	]
}
[/resultset]
