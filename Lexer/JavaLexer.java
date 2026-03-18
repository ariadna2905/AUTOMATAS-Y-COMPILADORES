import java.util.regex.*;
import java.util.*;
import java.nio.file.*;
import java.io.IOException;

public class JavaLexer {

    enum TokenType {
        JAVADOC, BLOCKCOMMENT, LINECOMMENT, STRINGLIT, CHARLIT,
        FLOATLIT, HEXADECIMALLIT, BINARYLIT, OCTALLIT, INTEGERLIT,
        KEYWORD, IDENTIFIER, OPERATOR, SEPARATOR, WHITESPACE, UNKNOWN
    }

    record Token(TokenType type, String lexeme, int line) {
        public String toString() {
            return String.format("[L%-3d] %-18s → \"%s\"", line, type, lexeme);
        }
    }

    static List<LexicalError> errors = new ArrayList<>();

    static final String KW_PATTERN =
        "\\b(abstract|assert|boolean|break|byte|case|catch|char|" +
        "class|const|continue|default|do|double|else|enum|extends|" +
        "final|finally|float|for|if|implements|import|instanceof|" +
        "int|interface|long|new|package|private|protected|public|" +
        "return|short|static|super|switch|synchronized|this|throw|" +
        "throws|try|void|volatile|while|true|false|null)\\b";

    static final Pattern MASTER = Pattern.compile(
        "(?<JAVADOC>/\\*\\*[\\s\\S]*?\\*/)|" +
        "(?<BLOCKCOMMENT>/\\*[\\s\\S]*?\\*/)|" +
        "(?<LINECOMMENT>//[^\\n]*)|" +
        "(?<STRINGLIT>\"([^\"\\\\]|\\\\.)*\")|" +
        "(?<CHARLIT>'([^'\\\\]|\\\\.)')|" +
        "(?<FLOATLIT>[0-9][0-9_]*\\.[0-9][0-9_]*([eE][+-]?[0-9]+)?[fFdD]?)|" +
        "(?<HEXADECIMALLIT>0[xX][0-9a-fA-F][0-9a-fA-F_]*[lL]?)|" +
        "(?<BINARYLIT>0[bB][01][01_]*[lL]?)|" +
        "(?<OCTALLIT>0[0-7]+[lL]?)|" +
        "(?<INTEGERLIT>0|[1-9][0-9_]*[lL]?)|" +
        "(?<KEYWORD>" + KW_PATTERN + ")|" +
        "(?<IDENTIFIER>[a-zA-Z_$][a-zA-Z0-9_$]*)|" +
        "(?<OPERATOR>==|!=|<=|>=|&&|\\|\\||<<|>>>|>>|\\+\\+|--|" +
        "\\+=|-=|\\*=|/=|%=|&=|\\|=|\\^=|<<=|>>=|" +
        "[+\\-*/%<>=!&|^~?:])|" +
        "(?<SEPARATOR>[(){}\\[\\];,.])|" +
        "(?<WHITESPACE>[ \\t\\r\\n]+)"
    );

    public static class LexicalError extends RuntimeException {
        private final int line, column;
        private final char illegal;

        public LexicalError(char c, int line, int col) {
            super(String.format(
                "Error léxico [línea %d, col %d]: carácter ilegal '%c' (U+%04X)",
                line, col, c, (int) c
            ));
            this.line = line;
            this.column = col;
            this.illegal = c;
        }
    }

    public static List<Token> tokenize(String source) {
        List<Token> tokens = new ArrayList<>();
        Matcher m = MASTER.matcher(source);
        int line = 1, pos = 0;

        while (m.find()) {
            if (m.start() > pos) {
                String unknown = source.substring(pos, m.start());
                tokens.add(new Token(TokenType.UNKNOWN, unknown, line));
            }

            if (m.group("WHITESPACE") != null) {
                line += m.group("WHITESPACE").chars().filter(c -> c == '\n').count();

            } else if (m.group("JAVADOC") != null) {
                tokens.add(new Token(TokenType.JAVADOC, m.group(), line));

            } else if (m.group("BLOCKCOMMENT") != null) {
                tokens.add(new Token(TokenType.BLOCKCOMMENT, m.group(), line));

            } else if (m.group("LINECOMMENT") != null) {
                tokens.add(new Token(TokenType.LINECOMMENT, m.group(), line));

            } else if (m.group("STRINGLIT") != null) {
                tokens.add(new Token(TokenType.STRINGLIT, m.group(), line));

            } else if (m.group("CHARLIT") != null) {
                tokens.add(new Token(TokenType.CHARLIT, m.group(), line));

            } else if (m.group("FLOATLIT") != null) {
                tokens.add(new Token(TokenType.FLOATLIT, m.group(), line));

            } else if (m.group("HEXADECIMALLIT") != null) {
                tokens.add(new Token(TokenType.HEXADECIMALLIT, m.group(), line));

            } else if (m.group("BINARYLIT") != null) {
                tokens.add(new Token(TokenType.BINARYLIT, m.group(), line));

            } else if (m.group("OCTALLIT") != null) {
                tokens.add(new Token(TokenType.OCTALLIT, m.group(), line));

            } else if (m.group("INTEGERLIT") != null) {
                tokens.add(new Token(TokenType.INTEGERLIT, m.group(), line));

            } else if (m.group("KEYWORD") != null) {
                tokens.add(new Token(TokenType.KEYWORD, m.group(), line));

            } else if (m.group("IDENTIFIER") != null) {
                tokens.add(new Token(TokenType.IDENTIFIER, m.group(), line));

            } else if (m.group("OPERATOR") != null) {
                tokens.add(new Token(TokenType.OPERATOR, m.group(), line));

            } else if (m.group("SEPARATOR") != null) {
                tokens.add(new Token(TokenType.SEPARATOR, m.group(), line));
            }

            pos = m.end();
        }

        return tokens;
    }

    public static void main(String[] args) {
        try {
            String path = "ejemplo.txt";

            String source = Files.readString(Path.of(path));

            List<Token> tokens = tokenize(source);

            for (Token t : tokens) {
                System.out.println(t);
            }

        } catch (IOException e) {
            System.err.println("Error al leer el archivo: " + e.getMessage());
        }
    }
}