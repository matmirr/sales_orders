const cds = require("@sap/cds");

const {
    SalesOrders,
    SalesOrderItems
} = cds.entities("com.matmir");

const createSalesOrder = (order) => {

    return INSERT.into(SalesOrders).entries({
        Email: order.Email,
        FirstName: order.FirstName,
        LastName: order.LastName,
        Country: order.Country_ID,
        CreatedOn: order.CreatedOn,
        DeliveryDate: order.DeliveryDate,
        OrderStatus: order.OrderStatus
    })

};

const processCreation = (req, resolve, reject) => {

    console.log("resolve:", resolve);
    console.log("reject:", reject);

    if (typeof resolve !== "undefined") {

        return req.data;

    } else {

        req.error(409, "Record Not Inserted");

    }

};

const readAll = () => SELECT.from(SalesOrders);

const updateSalesOrder = (order) => {

    return [
        UPDATE(SalesOrders, order.ID).set({
            Email: order.Email,
            FirstName: order.FirstName,
            LastName: order.LastName,
            Country: order.Country_ID,
            DeliveryDate: order.DeliveryDate,
            OrderStatus: order.OrderStatus
        }),
    ]
};

const processModification = (req, resolve, reject) => {

    console.log("resolve:", resolve);
    console.log("reject:", reject);

    // resolve[0] == 0 -> Record not found!
    if (resolve[0] == 0) {

        req.error(409, "Record Not Found");

    }
};

const deleteSalesOrder = (order) => {

    // Implementar borrado en posiciones
    return DELETE.from(SalesOrders).where({
        ID: order.ID,
    })

};

const processDeletion = (req, resolve, reject) => {

    console.log("resolve:", resolve);
    console.log("reject:", reject);

    if (resolve !== 1) {
        req.error(409, "Record Not Found");
    }

};

const getTotalPrice = async (salesOrder) => {

    let items = await SELECT.from(SalesOrderItems)
        .columns(['SalesOrder_ID', 'Price', 'Quantity'])
        .where({ SalesOrder_ID: salesOrder.ID });

    let totalPrice = 0;

    items.forEach(i => {
        let totalLine = i.Price * i.Quantity
        totalPrice += totalLine
    });

    return totalPrice;

}

module.exports = (srv) => {

    //***BEFORE->CREATE***//
    srv.before("CREATE", 'SalesOrders', (req) => {

        req.data.CreatedOn = new Date().toISOString().slice(0, 10);
        req.data.OrderStatus_ID = 1; // submitted     

        return req

    });

    //*******CREATE*******//
    srv.on("CREATE", SalesOrders, async (req) => {

        let result = await cds
            .transaction(req)
            .run(createSalesOrder(req.data))
            .then((resolve, reject) => processCreation(req, resolve, reject))
            .catch((err) => {
                console.log(err);
                req.error(err.code, err.message);
            });

        console.log("Before End", result);

        return result;

    });

    //********READ********//
    srv.on("READ", SalesOrders, async () => {

        return await readAll();

    });

    //****AFTER-READ****//
    srv.after("READ", 'SalesOrders', async (data) => {

        let orders = [];

        if (Array.isArray(data)) {

            orders = data;

        } else {

            orders[0] = data;

        }

        orders.forEach( async order => {
            order.TotalPrice = await getTotalPrice(order);

        })

        return await data;

    });

    //*******UPDATE*******//
    srv.on("UPDATE", SalesOrders, async (req) => {

        let result = await cds
            .transaction(req)
            .run(updateSalesOrder(req.data))
            .then((resolve, reject) => processModification(req, resolve, reject))
            .catch((err) => {
                console.log(err);
                req.error(err.code, err.message);
            });

        console.log("Before End", result);

        return result;

    });

    //*******DELETE*******//
    srv.on("DELETE", SalesOrders, async (req) => {

        let result = await cds
            .transaction(req)
            .run(deleteSalesOrder(req.data))
            .then((resolve, reject) => processDeletion(req, resolve, reject))
            .catch((err) => {
                console.log(err);
                req.error(err.code, err.message);
            });

        console.log("Before End", result);

        return result;

    });

};