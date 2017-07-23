shared {String*} subscribeNews => {"""Obama visited Facebook headquarters: http://bit.ly/xyz @elversatile"""};

shared class OOPApiCrawler() {
    Iterator<String> iterator = subscribeNews.iterator();

    shared String|Finished nextNews() => iterator.next();
}