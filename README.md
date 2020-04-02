Drone plugin for notification on Microsoft Teams

Sample drone.yml content for notification  
```yaml
---
kind: pipeline
type: docker
name: default

steps:
  <...>


  - name: notify
    image: ykorzikowski/drone_plugin_teams
    settings:
      webhook: https://outlook.office.com/webhook/<..>
    environment:
      TZ: Europe/Brussels
    when:
      branch: master
      status: [ success, failure ]

```

```
Test me:
docker run -e TZ=Europe/Brussels -e DRONE_TAG=TEST -e DRONE_BUILD_FINISHED=1585848656 -e PLUGIN_WEBHOOK=https://outlook.office.com/webhook/<...> ykorzikowski/drone_plugin_teams
````

![notification](https://raw.githubusercontent.com/ykorzikowski/drone_plugin_teams/master/notification.png)
![notification-error](https://raw.githubusercontent.com/ykorzikowski/drone_plugin_teams/master/notification_failed.png)
