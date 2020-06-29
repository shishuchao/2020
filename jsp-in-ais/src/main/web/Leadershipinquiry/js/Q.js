/*
* 决策支持统计首页中会有大量的Ajax请求，为了避免请求风暴，并照顾浏览器（主要是IE）兼容性，这里简单写了一个类Promise的对象
* 顺序发出请求，以便分摊网络及浏览器的负担
*/

var _Q = function(){
    this.tasks = [];
    this.stop = false;
    this.running = false;
    this.finishFn = null;
    this.data = null; // 参数
};

/**
 * fn 为任务函数，原型 function(q, data) q 为调度对象，data为上一个任务传递过来的参数
 * @param fn
 */
_Q.prototype.then = function(fn) {
    if (this.finishFn) return;
    this.tasks.push(fn);
    return this;
};

_Q.prototype.finish = function(fn) {
    this.finishFn = fn;
    return this;
};

/**
 * 函数别名
 * @type {(function(*=): _Q)|*}
 */
_Q.prototype.add = _Q.prototype.then;

/**
 * 函数别名
 * @type {(function(*=): _Q)|*}
 */
_Q.prototype.append = _Q.prototype.then;

_Q.prototype.start = function(data) {
    this.running = true;
    this.data = data;
    this.next();
};

/**
 * 人为延迟一定时间，也是为了加大请求间隔
 * @param mils 毫秒数
 * @returns {*}
 */
_Q.prototype.sleep = function(mils) {
    return this.then(function(q){
        setTimeout(function(){
            q.next();
        }, mils);
    });
}

_Q.prototype.next = function(data) {
    var c_task = this.tasks.shift();
    if (data) this.data = data;
    if (c_task)
        c_task(this);
    else
        this.abort()
};

/**
 * 放弃一次调度机会，有时候同步方法需要使用调度，可以使用这个方法达到异步目的
 * @param mils
 */
_Q.prototype.nextTick = function(mils) {
    var self = this;
    setTimeout(function(){
        self.next();
    }, mils || 10);
};

_Q.prototype.abort = function() {
    this.stop = true;
    this.tasks = [];
    this.running = false;
    this.data = null;
    try {
        if (this.finishFn) this.finishFn();
    } catch (e) {}
};

_Q.prototype.clear = function() {
    this.abort();
};
window.Q = _Q;