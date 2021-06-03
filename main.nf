nextflow.enable.dsl = 2

input = Channel.from([[[id:"test", sample:"subject"], file("bam"), file("bai")]])
intervals = Channel.from(file("1"), file("2"), file("3"))

input_int = input.combine(intervals)

input_int.map{ meta, bam, bai, intervals ->
    meta.id = meta.id + "_" + intervals.baseName
    println "meta.id in map: " + meta.id
    [meta, bam, bai, intervals]
}.set{output}

output.view{ meta, bam, bai, intervals -> 
    "meta.id: " + meta.id
}

// Fix with clone() thanks to @mahesh-panchal
input = Channel.from([[[id:"test", sample:"subject"], file("bam"), file("bai")]])
intervals = Channel.from(file("1"), file("2"), file("3"))

input_int_2 = input.combine(intervals)

input_int_2.map{ meta, bam, bai, intervals ->
    new_meta = meta.clone()
    new_meta.id = new_meta.id + "_" + intervals.baseName
    println "new_meta.id in map: " + new_meta.id
    [new_meta, bam, bai, intervals]
}.set{output_2}

output_2.view{ meta, bam, bai, intervals -> 
    "meta.id: " + meta.id
}