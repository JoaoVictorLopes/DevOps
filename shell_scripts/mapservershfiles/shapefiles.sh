# DOWNLOAD
wget https://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2020/Brasil/BR/BR_Municipios_2020.zip
wget https://www.gov.br/infraestrutura/pt-br/centrais-de-conteudo/rodovias-zip

# EXTRACT
unzip BR_Municipios_2020.zip -d mapservershfiles/data/municipios
unzip rodovias-zip -d mapservershfiles/data/rodovias

# CLEAN
rm BR_Municipios_2020.zip
rm rodovias-zip
