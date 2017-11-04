# Antlr4  for Java (Maven) and Intellij Idea

1. Inslall Oracle Java JDK и Intellij Idea, (you can skip this step), and run Intellij Idea


2. File-Setting-Plugins

![Image setting](https://github.com/savimar/Antlr-Java-and-Intellij-Idea/blob/master/src/main/resources/img/setting.png)

Enter in the search field ANTLR and install plugin ANTLR v4 grammar plugin. Perhaps, you will need an additional search on all repositories.

![Image plugin](https://github.com/savimar/Antlr-Java-and-Intellij-Idea/blob/master/src/main/resources/img/plugins.png)

3) For the Maven project add into pom.xml 
in dependencies
```
 <dependency>
            <groupId>org.antlr</groupId>
            <artifactId>antlr4-runtime</artifactId>
            <version>4.7</version>
 </dependency> 
 ```
 in  plugins
 ```
  <plugin>
    <groupId>org.antlr</groupId>
                <artifactId>antlr4-maven-plugin</artifactId>
                <version>4.7</version>
                <executions>
                    <execution>
                        <goals>
                            <goal>antlr4</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
 ```

View details https://github.com/antlr/antlr4/blob/master/doc/java-target.md

4. Next, create file  manually a grammar file with the extension.g4 and add it into project.  For example, this example is from the official site called Hello.g4

 ```
// Define a grammar called Hello
grammar Hello;
r  : 'hello' ID ;         // match keyword hello followed by an identifier
ID : [a-z]+ ;             // match lower-case identifiers
WS : [ \t\r\n]+ -> skip ; // skip spaces, tabs, newlines

 ```
 
 
 5. Next, right-click on the second line of the file, which starts with "r" and select the menu item Test Rule r
 
 ![Image test_rule](https://github.com/savimar/Antlr-Java-and-Intellij-Idea/blob/master/src/main/resources/img/test_rule.png)
 
 
 
 ![Image plugin_start](https://github.com/savimar/Antlr-Java-and-Intellij-Idea/blob/master/src/main/resources/img/plugin_start.png)
 
 
 6. Click the grammar file with the right mouse button, select the menu item Configute ANTLR Recoqnizer  and generate a parser
 
 ![Image generate_recoqnizer](https://github.com/savimar/Antlr-Java-and-Intellij-Idea/blob/master/src/main/resources/img/generate_recoqnizer.png)
 

 
 7. Next click the file again with the right click and select the menu item Configute ANTLR, 
 
 ![Image configure](https://github.com/savimar/Antlr-Java-and-Intellij-Idea/blob/master/src/main/resources/img/configure.png)
 
and a window opens for configuring the generation of files
 
 ![Image config](https://github.com/savimar/Antlr-Java-and-Intellij-Idea/blob/master/src/main/resources/img/config.png)
 
 Fill the fields as in the picture and click OK
 
 ![Image config_full](https://github.com/savimar/Antlr-Java-and-Intellij-Idea/blob/master/src/main/resources/img/config_full.png)
 
 ANTLR generates files for recognition. However, although the output directory is specified, a new gen folder in the project root is often created, and java does not recognize these files.
 
 ![Image пут](https://github.com/savimar/Antlr-Java-and-Intellij-Idea/blob/master/src/main/resources/img/gen.png)
 
The folder should either be marked with the right mouse button "Mark Directory As" on "Generated Sources Root" on the gen folder, or it transferred to the main project. In my case, the files were moved.
  
  ![Image files](https://github.com/savimar/Antlr-Java-and-Intellij-Idea/blob/master/src/main/resources/img/files.png)
  
  8. ANTLR generated such classes:
 Класс HelloParser.java  -this is the description of the parser class of the corresponding grammar Hello: 
```
 public class HelloParser extends Parser { ... }
```
Класс HelloLexer.java  - this is the description of the class of the lexer of the corresponding grammar HelloInit: 
```
 public class HelloLexer extends Lexer { ... }
```
 Hello.tokens, HelloLexer.tokens  - These are helper classes that contain information about tokens
 HelloListener.java, HelloBaseListener.java, HelloBaseVisitor, HelloVisitor - these are classes that contain method descriptions that allow you to perform certain actions when traversing a syntax tree

  
9.  Then add the class HelloWalker (although this class is not required, this code can be changed and added to the Main for outputting information)
  ``` 
  public class HelloWalker extends HelloBaseListener {
    public void enterR(HelloParser.RContext ctx ) {
        System.out.println( "Entering R : " + ctx.ID().getText() );
    }

    public void exitR(HelloParser.RContext ctx ) {
        System.out.println( "Exiting R" );
    }
}
 ```
 
10. And add class Main - entry point
 
  ```
  public class Main {
    public static void main( String[] args) throws Exception
    {
        HelloLexer lexer = new HelloLexer(new ANTLRInputStream("hello world"));
        CommonTokenStream tokens = new CommonTokenStream( lexer );
        HelloParser parser = new HelloParser( tokens );
        ParseTree tree = parser.r();
        ParseTreeWalker walker = new ParseTreeWalker();
        walker.walk( new HelloWalker(), tree );
    }
}
 ```

11. Run the method main
 ```
Entering R : world
Exiting R
 ```
  
 
 
  
 
 
 
 
 

 
