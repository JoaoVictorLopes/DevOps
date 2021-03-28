// MapServer Template
[resultset layer=layer_rodovias]
{
	"type": "FeatureCollection",
	"features": [
		[feature trimlast=","]
		{
			"type": "Feature",
			"id": "[lrn]",
			"layer": "[cl]",
			"geometry": {
				"type": "LineString",
				"coordinates": "[shpxy precision=2 xh=( yf=)]"
			},
			"properties": {
				"OBJECTID": "[OBJECTID]",
				"id_trecho": "[id_trecho]",
				"vl_br": "[vl_br]",
				"sg_uf": "[sg_uf]",
				"nm_tipo_tr": "[nm_tipo_tr]",
				"vl_codigo": "[vl_codigo]",
				"ds_local_i": "[ds_local_i]",
				"ds_local_f": "[ds_local_f]",
				"vl_km_inic": "[vl_km_inic]",
				"vl_km_fina": "[vl_km_fina]",
				"vl_extensa": "[vl_extensa]",
				"ds_sup_fed": "[ds_sup_fed]",
				"ds_obra": "[ds_obra]",
				"ul": "[ul]",
				"ds_coinc": "[ds_coinc]",
				"ds_tipo_ad": "[ds_tipo_ad]",
				"ds_ato_leg": "[ds_ato_leg]",
				"est_coinc": "[est_coinc]",
				"sup_est_co": "[sup_est_co]",
				"ds_jurisdi": "[ds_jurisdi]",
				"ds_superfi": "[ds_superfi]",
				"ds_legenda": "[ds_legenda]",
				"sg_legenda": "[sg_legenda]",
				"leg_multim": "[leg_multim]",
				"versao_snv": "[versao_snv]",
				"id_versao": "[id_versao]",
				"marcador": "[marcador]",
				"Shape_Leng": "[Shape_Leng]"
			}
		},
		[/feature]
	]
}
[/resultset]
