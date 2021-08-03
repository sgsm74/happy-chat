abstract class FetchContactsListState {
  FetchContactsListState();
}

class InitialFetchContatctsList extends FetchContactsListState {
  InitialFetchContatctsList();
}

class LoadingFetchContatctsList extends FetchContactsListState {
  LoadingFetchContatctsList();
}

class SuccessFetchContatctsList extends FetchContactsListState {
  Map<String, dynamic> data;
  SuccessFetchContatctsList(this.data);
}

class FailedFetchContatctsList extends FetchContactsListState {
  FailedFetchContatctsList();
}
