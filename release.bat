set JAVA_HOME="C:\tools\java\jdk-17.0.6"

set new_version=1.0.6

set jsh_content=^
    Files.writeString(Path.of("README.md"), ^
        Files.readString(Path.of("README.md")).replaceAll(^
            "<brinvex-db-manager.version>(.*)</brinvex-db-manager.version>", ^
            "<brinvex-db-manager.version>%%s</brinvex-db-manager.version>".formatted(System.getenv("new_version"))), ^
    StandardOpenOption.TRUNCATE_EXISTING);

echo %jsh_content% | %JAVA_HOME%\bin\jshell -

call mvnw clean package
call mvnw versions:set -DnewVersion=%new_version%
call mvnw versions:commit
call mvnw clean deploy -DskipTests