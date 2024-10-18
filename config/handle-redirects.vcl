if (obj.status == 600) {
  set obj.status = 301;
  set obj.http.Location = obj.response;
  return (deliver);
}