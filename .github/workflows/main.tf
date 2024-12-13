name: Build Java Project from jar-tomcat Repo

on:
  workflow_dispatch: # Allows manual triggering of the workflow

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      # Step 1: Checkout this repository (workflow repository)
      - name: Checkout this repository
        uses: actions/checkout@v3

      # Step 2: Clone the jar-tomcat repository
      - name: Clone jar-tomcat repository
        run: |
          git clone https://github.com/mintuky1508/jar-tomcat.git java-code

      # Step 3: Set up JDK
      - name: Set up JDK
        uses: actions/setup-java@v3
        with:
          java-version: '17' # Adjust based on the Java version in your project
          distribution: 'temurin'

      # Step 4: Build the Java project
      - name: Build with Maven
        run: |
          cd java-code # Navigate into the cloned repository
          mvn clean package

      # Step 5: Upload the built artifact
      - name: Upload JAR/WAR artifact
        uses: actions/upload-artifact@v3
        with:
          name: built-java-artifact
          path: java-code/target/*.jar # Adjust for WAR files if needed
