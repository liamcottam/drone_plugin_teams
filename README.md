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
    when:
      branch: master
      status: [ success, failure ]

```
![notification](https://raw.githubusercontent.com/ykorzikowski/drone_plugin_teams/master/notification.png)
![notification-error](https://raw.githubusercontent.com/ykorzikowski/drone_plugin_teams/master/notification_failed.png)
