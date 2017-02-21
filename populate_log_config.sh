#!/usr/bin/env bash

cat << EOF >> /elasticsearch/logging.yml
 # you can override this using by setting a system property, for example -Des.logger.level=DEBUG
es.logger.level: INFO
rootLogger: \${es.logger.level}, console, file
logger:
  # log action execution errors for easier debugging
  action: DEBUG
  # reduce the logging for aws, too much is logged under the default INFO
  com.amazonaws: WARN

appender:
    file:
        type: org.apache.log4j.rolling.RollingFileAppender
        file: \${path.logs}/\${cluster.name}.log
        rollingPolicy: org.apache.log4j.rolling.TimeBasedRollingPolicy
        rollingPolicy.FileNamePattern: \${path.logs}/\${cluster.name}.log.%d{yyyy-MM-dd}.gz
        layout:
          type: pattern
          conversionPattern: "%d{ISO8601}[%-5p][%-25c] %m%n"
    console:
        type: console
        layout:
            type: consolePattern
            conversionPattern: "[%d{ISO8601}][%-5p][%-25c] %m%n"
EOF
