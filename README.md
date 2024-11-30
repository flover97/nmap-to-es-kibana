# Nmap vulners scan data to elasticsearch (with Kibana dashboards)
The script displays the information from the nmap voluners scan in the ELK stack

# Preview:
![Preview](https://github.com/flover97/nmap-to-es-kibana/blob/master/screenshots/Screenshot_2020-01-16%20Vulners%20-%20Kibana.png)

Please install requirements and set vars in run.sh.
Dashboards searches and visualisations locates in kibana folder.

```bash
# Use Kibana port and IP, NOT elasticsearch
curl -X POST http://server_ip/api/saved_objects/_import -H "kbn-xsrf: true" --form file=@./kibana/export.ndjson
```

Used reps https://github.com/vulnersCom/nmap-vulners.git and https://github.com/ChrisRimondi/VulntoES
