Drone plugin for notification on Microsoft Teams

Sample drone.yml content for notification  
```yaml
---
kind: pipeline
type: docker
name: default

steps:
  <...>

notify:
  image: ykorzikowski/drone_plugin_teams
  webhook: https://outlook.office.com/webhook/<...>
  when:
    branch: master

```
![notification](https://raw.githubusercontent.com/ykorzikowski/drone_plugin_teams/master/notification.png)
