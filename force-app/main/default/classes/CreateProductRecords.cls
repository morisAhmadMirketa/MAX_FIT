public class CreateProductRecords {
    public static HttpResponse createRecord(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://fakestoreapi.com/products');
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if(response.getStatusCode() == 200){
            List<Object> productList = (List<object>) JSON.deserializeUntyped(response.getBody());

            List<product2> proList = new List<product2>();
            List<PriceBookEntry> entryList = new List<PriceBookEntry>();
            List<PriceBookEntry> entryList2 = new List<PriceBookEntry>();

            PriceBook2 pb = new PriceBook2(Name = 'morisahmad-pricebook', Description='Price Book', IsActive=true);
            insert pb;

            PriceBook2 standardPb  = new PriceBook2();

            if(Test.isRunningTest()){
                id pbid = Test.getStandardPriceBookId();
                standardPB.id = pbid;
            }
            else{
                standardPb = [SELECT id from PriceBook2 where isStandard=true];
            }

            for(Object product : productList){
                Map<String,Object> productMap = (Map<String,Object>) product;

                String title = (String) JSON.serialize(productMap.get('title'));
                title = title.substring(1,title.length()-1);

                string descript = (string) JSON.serialize(productMap.get('description'));
                descript = descript.substring(1,descript.length()-1);

                product2 p = new product2(ProductCode = (String) JSON.serialize(productMap.get('id')), Name = title, Description = descript);

                proList.add(p);
            }

            insert proList;

            for(integer i=0; i< productList.size();i++){
                Object product = productList.get(i);
                Id productId = proList.get(i).Id;

                Map<String, Object> productMap = (Map<String,Object>) product;

                Decimal strToDec = decimal.valueOf(JSON.serialize(productMap.get('price')));

                PriceBookEntry entry = new PriceBookEntry(
                    Pricebook2Id = standardPb.Id,
                    product2Id = productId,
                    UnitPrice = strToDec,
                    IsActive = true
                );

                entryList.add(entry);
            }

            insert entryList;

            for(integer i=0; i<productList.size();i++){
                Object product = productList.get(i);
                Id productId = proList.get(i).Id;

                Map<String,Object> productMap = (Map<String,Object>) product;

                Decimal strToDec = decimal.valueOf(JSON.serialize(productMap.get('price')));

                PriceBookEntry entry = new PriceBookEntry(
                    Pricebook2Id = pb.Id,
                    Product2Id = ProductId,
                    UnitPrice = strToDec,
                    IsActive = true);

                entryList2.add(entry);
            }

            insert entryList2;
        }
        return response;
    }
}