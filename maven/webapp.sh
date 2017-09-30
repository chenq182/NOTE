mvn archetype:generate -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-webapp -DgroupId=org.trimps.sample -DartifactId=sampleproject

mvn package
mvn idea:idea
mvn eclipse:eclipse
