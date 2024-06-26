#!/bin/bash
JDTLS_CONFIG="/usr/share/java/jdtls/config_linux"
JDTLS_PLUGINS="/usr/share/java/jdtls/plugins/"
JAR=$JDTLS_PLUGINS"org.eclipse.equinox.launcher_*.jar"
#For system
echo $JAR1
echo $JAR
GRADLE_HOME="$HOME/.local/lib/sdkman/candidates/gradle/current/bin/gradle" java \
  -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=localhost:8000 \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Xbootclasspath/a:$HOME/.local/lib/lombok/lombok.jar \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true \
  -Dlog.level=ALL \
  -Xms256M \
  -Xmx1G \
  -jar $(echo "$JAR") \
  -javaagent:$HOME/.local/lib/lombok/lombok.jar \
  -configuration "$JDTLS_CONFIG" \
  -data "${1:-$HOME/.cache/jdtls_workspaces}" \
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAME
