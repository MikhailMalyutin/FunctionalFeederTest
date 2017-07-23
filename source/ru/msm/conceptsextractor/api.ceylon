import ru.msm.feedscrawler {
    subscribeNews,
    OOPApiCrawler
}

shared interface ConceptType of entity | link | twitterUsername | text {
}
shared object text satisfies ConceptType {
}
shared object entity satisfies ConceptType {
}
shared object link satisfies ConceptType {
}
shared object twitterUsername satisfies ConceptType {
}

shared class Concept(
            shared Integer startPosition,
            shared Integer endPositiom,
            shared ConceptType conceptType
        ) {}

{Concept+} extractConcepts(String newsText)
        => {
               Concept(14, 22, entity),
               Concept(0, 5, entity),
               Concept(55, 66, twitterUsername),
               Concept(37, 54, link)
           };

shared {<String->{Concept*}>*} subscribeFeedsAndConcepts
    => subscribeNews.map((news)
        => news -> extractConcepts(news));

shared class NewsWithConcepts(shared String news) {
    shared {Concept*} concepts => extractConcepts(news);
}

shared class OOPApiContextExtractor(OOPApiCrawler crawler) {
    shared NewsWithConcepts|Finished nextNewsWithConcepts() {
        value newsOrFinished = crawler.nextNews();
        if (is Finished newsOrFinished) {
            return newsOrFinished;
        }
        return NewsWithConcepts(newsOrFinished);
    }
}