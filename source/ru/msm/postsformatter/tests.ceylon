import ceylon.test {
    assertEquals,
    test
}
import ru.msm.conceptsextractor {
    OOPApiContextExtractor
}
import ru.msm.feedscrawler {
    OOPApiCrawler
}
shared
test
void integrationForFunctionStyleApi() {
    value firstFormattedItem = subsccribeFormatted().first;
    print(firstFormattedItem);
    assertEquals(firstFormattedItem,
        """<strong>Obama</strong> visited <strong>Facebook</strong> headquarters: <a
                   href="http://bit.ly/xyz">http://bit.ly/xyz </a> @ <a
                   href="http://twitter.com/elversatil">elversatil</a>e""".normalized);
}

shared
test
void integrationForOOPStyleApi() {
    value formattedNewsApi = OOPApiFormattedNews(OOPApiContextExtractor(OOPApiCrawler()));
    value firstFormattedItem = formattedNewsApi.nextFormattedNews();
    print(firstFormattedItem);
    assertEquals(firstFormattedItem,
        """<strong>Obama</strong> visited <strong>Facebook</strong> headquarters: <a
                   href="http://bit.ly/xyz">http://bit.ly/xyz </a> @ <a
                   href="http://twitter.com/elversatil">elversatil</a>e""".normalized);
}