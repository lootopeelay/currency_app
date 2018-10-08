wget 'https://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml' -O - > rates.xml
rake import:rates