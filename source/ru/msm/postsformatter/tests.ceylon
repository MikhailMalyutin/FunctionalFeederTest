import ceylon.test {
    assertEquals,
    test
}
shared
test
void runAll() {
    value firstFormattedItem = subsccribeFormatted().first;
    assertEquals(firstFormattedItem,
        """<strong>Obama</strong> visited <strong>Facebook</strong> headquarters: <a
                   href="http://bit.ly/xyz">http://bit.ly/xyz </a> @ <a
                   href="http://twitter.com/elversatil">elversatil</a>e""".normalized);
    print(firstFormattedItem);
}