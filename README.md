# Antlr4  for Java (Maven) and Intellij Idea

1)Поставить Oracle Java JDK и Intellij Idea, запустить Intellij Idea


2)File-Setting-Plugins

![Image setting](https://github.com/savimar/Antlr-Java-and-Intellij-Idea/blob/master/src/main/resources/img/setting.png)

Bвести в поле поиска ANTLR и поставить плагин ANTLR v4 grammar plugin. Возможно, понадобится дополнительный поиск по всем репозиториям.

![Image plugin](https://github.com/savimar/Antlr-Java-and-Intellij-Idea/blob/master/src/main/resources/img/plugins.png)

3)Для Maven проекта добавить в pom.xml или создать новый проект.

```
 <dependency>
            <groupId>org.antlr</groupId>
            <artifactId>antlr4-runtime</artifactId>
            <version>4.7</version>
 </dependency> 
 ```
 и
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

Подробности https://github.com/antlr/antlr4/blob/master/doc/java-target.md

4) Далее создам и добавляем вручную файл грамматики с расширением .g4. Имя файла должно совпадать с словом после grammar в первой строчке. Как составлять грамматику - это уже тема для отдельной статьи. Для примера взято содержимое примера с официального сайта для файла Hello.g4

 ```
// Define a grammar called Hello
grammar Hello;
r  : 'hello' ID ;         // match keyword hello followed by an identifier
ID : [a-z]+ ;             // match lower-case identifiers
WS : [ \t\r\n]+ -> skip ; // skip spaces, tabs, newlines

 ```
 
 
 5)
 Далее правой кнопкой мыши кликнуть по второй строчке файла, которая начинается с r и выбрать пункт меню Test Rule r
 
 ![Image test_rule](https://github.com/savimar/Antlr-Java-and-Intellij-Idea/blob/master/src/main/resources/img/test_rule.png)
 
 Внизу откроются окна проверки грамматики. Хоть файл и с официального сайта, но лично у меня выдет ошибки при тестинге. Тем не менее генерируются рабоие файлы.
 
 ![Image plugin_start](https://github.com/savimar/Antlr-Java-and-Intellij-Idea/blob/master/src/main/resources/img/plugin_start.png)
 
 
 6)Кликаем по файлу грамматики правой кнопкой мыши, выбираем пункт меню Configute ANTLR Recoqnizer  и генерируем парсер 
 
 ![Image generate_recoqnizer](https://github.com/savimar/Antlr-Java-and-Intellij-Idea/blob/master/src/main/resources/img/generate_recoqnizer.png)
 
 После этого появися в правом нижнем углу сообщение
 
 
 7)Далее снова кликаем по файлу правой кнопкой мыши и выбираем пункт меню Configute ANTLR, 
 
 ![Image configure](https://github.com/savimar/Antlr-Java-and-Intellij-Idea/blob/master/src/main/resources/img/configure.png)
 
 и выходит окно  для конфигурирования генерации файлов
 
 ![Image config](https://github.com/savimar/Antlr-Java-and-Intellij-Idea/blob/master/src/main/resources/img/config.png)
 
 В этом окне вводим данные о папке назначения и языке программирования, в нашем случае Java, нужны ли  visitor или listener, а также   другую требуемую информацию, и нажимаем  кнопку ОК. 
 
 ![Image config_full](https://github.com/savimar/Antlr-Java-and-Intellij-Idea/blob/master/src/main/resources/img/config_full.png)
 
 И ANTLR после этого генерирует файлы для распознавания. Тем не менее, хотя выходной каталог указан, часто создается новая папка gen в корне проекта, причем  java не распознает эти файлы.
 
 ![Image пут](https://github.com/savimar/Antlr-Java-and-Intellij-Idea/blob/master/src/main/resources/img/gen.png)
 
 Для того, чтобы java ее увидела, ее нужно пометить правой кнопкой мыши «Mark Directory As», с «Generated Sources Root» на папку подменю, либо перенестив основной проект, иначе java не увидит сгенерированные файлы. В этом случае файлы перенесены.
  
  ![Image files](https://github.com/savimar/Antlr-Java-and-Intellij-Idea/blob/master/src/main/resources/img/files.png)
  
  После этого добавим класс HelloWalker
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
 
 И, наконец, класс Main - точку входа в программу
 
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

Запускаем метод  main, и получаем на выходе в консоли успешно отработанный парсинг
 ```
Entering R : world
Exiting R
 ```
  
 
 
  
 
 
 
 
 

 
