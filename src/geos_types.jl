abstract type AbstractGeometry end

function Base.show(io::IO, geo::AbstractGeometry)
    compact = get(io, :compact, false)
    if compact
        print(io, typeof(geo), "(...)")
    else
        s = writegeom(geo)
        print(io, s)
    end
end

mutable struct Point <: AbstractGeometry
    ptr::GEOSGeom
    context::GEOSContext
    # create a point from a pointer - only makese sense if it is a pointer to a point, otherwise error
    function Point(obj::Union{Point,GEOSGeom}, context::GEOSContext = get_global_context())
        id = LibGEOS.geomTypeId(obj, context)
        point = if id == GEOS_POINT
            point = new(cloneGeom(obj, context), context)
        else
            error("LibGEOS: Can't convert a pointer to an element with a GeomType ID of $id to a point (yet).
                   Please open an issue if you think this conversion makes sense.")
        end
        finalizer(destroyGeom, point)
        point
    end
    # create a point from a vector of floats
    Point(coords::Vector{Float64}, context::GEOSContext = get_global_context()) =
        Point(createPoint(coords, context), context)
    Point(x::Real, y::Real, context::GEOSContext = get_global_context()) =
        Point(createPoint(x, y, context), context)
    Point(x::Real, y::Real, z::Real, context::GEOSContext = get_global_context()) =
        Point(createPoint(x, y, z, context), context)
end

mutable struct MultiPoint <: AbstractGeometry
    ptr::GEOSGeom
    context::GEOSContext
    # create a multipoint from a pointer - only makes sense if it is a pointer to a multipoint
    # or to a point, otherwise error
    function MultiPoint(obj::Union{Point,MultiPoint,GEOSGeom}, context::GEOSContext = get_global_context())
        id = LibGEOS.geomTypeId(obj, context)
        multipoint = if id == GEOS_MULTIPOINT
            new(cloneGeom(obj, context), context)
        elseif id == GEOS_POINT
            new(createCollection(GEOS_MULTIPOINT,
                                 [cloneGeom(obj, context)],
                                 context),
                context
               )
        else
            error("LibGEOS: Can't convert a pointer to an element with a GeomType ID of $id to a multipoint (yet).
                   Please open an issue if you think this conversion makes sense.")
        end
        finalizer(destroyGeom, multipoint)
        multipoint
    end
    # create a multipoint frome a vector of vector coordinates
    MultiPoint(multipoint::Vector{Vector{Float64}}, context::GEOSContext = get_global_context()) =
        MultiPoint(
            createCollection(
                GEOS_MULTIPOINT,
                GEOSGeom[createPoint(coords, context) for coords in multipoint],
                context),
            context)
    # create a multipoint from a list of points
    MultiPoint(points::Vector{LibGEOS.Point}, context::GEOSContext = get_context(points)) =
        MultiPoint(
            createCollection(
                GEOS_MULTIPOINT,
                points,
                context),
            context)
end

mutable struct LineString <: AbstractGeometry
    ptr::GEOSGeom
    context::GEOSContext
    # create a linestring from a linestring pointer, otherwise error
    function LineString(obj::Union{LineString,GEOSGeom}, context::GEOSContext = get_global_context())
        id = LibGEOS.geomTypeId(obj, context)
        line = if id == GEOS_LINESTRING
            new(cloneGeom(obj, context), context)
        else
            error("LibGEOS: Can't convert a pointer to an element with a GeomType ID of $id to a linestring (yet).
                   Please open an issue if you think this conversion makes sense.")
        end
        finalizer(destroyGeom, line)
        line
    end
    #create a linestring from a list of coordiantes
    function LineString(coords::Vector{Vector{Float64}}, context::GEOSContext = get_global_context())
        line = new(createLineString(coords, context), context)
        finalizer(destroyGeom, line)
        line
    end
end

mutable struct MultiLineString <: AbstractGeometry
    ptr::GEOSGeom
    context::GEOSContext
    # create a multiline string from a multilinestring or a linestring pointer, else error
    function MultiLineString(obj::Union{LineString,MultiLineString,GEOSGeom}, context::GEOSContext = get_global_context())
        id = LibGEOS.geomTypeId(obj, context)
        multiline = if id == GEOS_MULTILINESTRING
            new(cloneGeom(obj, context), context)
        elseif id == GEOS_LINESTRING
            new(createCollection(GEOS_MULTILINESTRING,
                                 [cloneGeom(obj, context)],
                                 context), context)
        else
            error("LibGEOS: Can't convert a pointer to an element with a GeomType ID of $id to a multi-linestring (yet).
                   Please open an issue if you think this conversion makes sense.")
        end
        finalizer(destroyGeom, multiline)
        multiline
    end
    # create a multilinestring from a list of linestring coordiantes
    MultiLineString(multiline::Vector{Vector{Vector{Float64}}},context::GEOSContext = get_global_context()) =
        MultiLineString(
            createCollection(
                GEOS_MULTILINESTRING,
                GEOSGeom[createLineString(coords, context) for coords in multiline],
                context),
            context)
end

mutable struct LinearRing <: AbstractGeometry
    ptr::GEOSGeom
    context::GEOSContext
    # create a linear ring from a linear ring pointer, otherwise error
    function LinearRing(obj::Union{LinearRing,GEOSGeom}, context::GEOSContext = get_global_context())
        id = LibGEOS.geomTypeId(obj, context)
        ring = if id == GEOS_LINEARRING
            new(cloneGeom(obj, context), context)
        else
            error("LibGEOS: Can't convert a pointer to an element with a GeomType ID of $id to a linear ring (yet).
                   Please open an issue if you think this conversion makes sense.")
        end
        finalizer(destroyGeom, ring)
        ring
    end
    # create linear ring from a list of coordinates -
    # first and last coordinates must be the same
    function LinearRing(coords::Vector{Vector{Float64}}, context::GEOSContext = get_global_context())
        ring = new(createLinearRing(coords, context), context)
        finalizer(destroyGeom, ring)
        ring
    end

end

mutable struct Polygon <: AbstractGeometry
    ptr::GEOSGeom
    context::GEOSContext
    # create polygon using GEOSGeom pointer - only makes sense if pointer points to a polygon or a linear ring to start with.
    function Polygon(obj::Union{Polygon,LinearRing,GEOSGeom}, context::GEOSContext = get_global_context())
        id = LibGEOS.geomTypeId(obj, context)
        polygon = if id == GEOS_POLYGON
            new(cloneGeom(obj, context), context)
        elseif id == GEOS_LINEARRING
            new(cloneGeom(createPolygon(obj, context), context), context)
        else
            error("LibGEOS: Can't convert a pointer to an element with a GeomType ID of $id to a polygon (yet).
                   Please open an issue if you think this conversion makes sense.")
        end
        finalizer(destroyGeom, polygon)
        polygon
    end
    # using vector of coordinates in following form:
    # [[exterior], [hole1], [hole2], ...] where exterior and holeN are coordinates where the first and last point are the same
    function Polygon(coords::Vector{Vector{Vector{Float64}}}, context::GEOSContext = get_global_context())
        exterior = createLinearRing(coords[1], context)
        interiors = GEOSGeom[createLinearRing(lr, context) for lr in coords[2:end]]
        polygon = new(createPolygon(exterior, interiors, context), context)
        finalizer(destroyGeom, polygon)
        polygon
    end
    # using multiple linear rings to form polygon with holes - exterior linear ring will be polygon boundary and list of interior linear rings will form holes
    Polygon(exterior::LinearRing, holes::Vector{LinearRing}, context::GEOSContext = get_context(exterior)) =
        Polygon(
            createPolygon(exterior,
                          holes,
                          context),
            context)
end

mutable struct MultiPolygon <: AbstractGeometry
    ptr::GEOSGeom
    context::GEOSContext
    # create multipolygon using a multipolygon or polygon pointer, else error
    function MultiPolygon(obj::Union{Polygon,MultiPolygon,GEOSGeom}, context::GEOSContext = get_global_context())
        id = LibGEOS.geomTypeId(obj, context)
        multipolygon = if id == GEOS_MULTIPOLYGON
            new(cloneGeom(obj, context), context)
        elseif id == GEOS_POLYGON
            new(createCollection(
                    GEOS_MULTIPOLYGON,
                    [cloneGeom(obj, context)],
                    context),
                context
               )
        else
            error("LibGEOS: Can't convert a pointer to an element with a GeomType ID of $id to a multi-polygon (yet).
                   Please open an issue if you think this conversion makes sense.")
        end
        finalizer(destroyGeom, multipolygon)
        multipolygon
    end

    # create multipolygon from list of Polygon objects
    MultiPolygon(polygons::Vector{Polygon}, context::GEOSContext = get_context(polygons)) =
        MultiPolygon(
            createCollection(
                GEOS_MULTIPOLYGON,
                polygons,
                context),
            context)

    # create multipolygon using list of polygon coordinates - note that each polygon can have holes as explained above in Polygon comments
    MultiPolygon(multipolygon::Vector{Vector{Vector{Vector{Float64}}}}, context::GEOSContext = get_global_context()) =
        MultiPolygon(
            createCollection(
                GEOS_MULTIPOLYGON,
                GEOSGeom[
                    createPolygon(
                        createLinearRing(coords[1], context),
                        GEOSGeom[createLinearRing(c, context) for c in coords[2:end]],
                        context)
                    for coords in multipolygon],
                context),
            context)
end

mutable struct GeometryCollection <: AbstractGeometry
    ptr::GEOSGeom
    context::GEOSContext
    # create a geometric collection from a pointer to a geometric collection, else error
    function GeometryCollection(obj::Union{GeometryCollection,GEOSGeom}, context::GEOSContext = get_global_context())
        id = LibGEOS.geomTypeId(obj, context)
        geometrycollection = if id == GEOS_GEOMETRYCOLLECTION
            new(cloneGeom(obj, context), context)
        else
            error("LibGEOS: Can't convert a pointer to an element with a GeomType ID of $id to a geometry collection (yet).
                   Please open an issue if you think this conversion makes sense.")
        end
        finalizer(destroyGeom, geometrycollection)
        geometrycollection
    end
    # create a geometric collection from a list of pointers to geometric objects
    GeometryCollection(collection::AbstractVector, context::GEOSContext = get_global_context()) =
        GeometryCollection(
            createCollection(
                GEOS_GEOMETRYCOLLECTION,
                collection,
                context),
            context)
end

const Geometry = Union{
    Point,
    MultiPoint,
    LineString,
    MultiLineString,
    LinearRing,
    Polygon,
    MultiPolygon,
    GeometryCollection,
}

"""
    clone(obj::Geometry, context=get_context(obj))

Create a deep copy of obj, optionally also moving it to a new context.
"""
function clone(obj::Geometry, context=get_context(obj))
    G = typeof(obj)
    # Note that all Geometry constructors
    # implicitly clone the pointer, in the following line
    G(obj, context)::G
end

"""

    get_context(obj::AbstractGeometry)::GEOSContext

Return the `GEOSContext` that `obj` belongs to. If obj is not a GEOS object with
a context, return the global context.
"""
get_context(obj::Geometry) = obj.context
get_context(obj::Any) = get_global_context()

mutable struct PreparedGeometry{G<:AbstractGeometry} <: AbstractGeometry
    ptr::Ptr{GEOSPreparedGeometry}
    ownedby::G
end

get_context(obj::PreparedGeometry) = get_context(obj.ownedby)

const geomtypes = [
    Point,
    LineString,
    LinearRing,
    Polygon,
    MultiPoint,
    MultiLineString,
    MultiPolygon,
    GeometryCollection,
]

Base.@kwdef struct IsApprox
    atol::Float64=0.0
    rtol::Float64=sqrt(eps(Float64))
end

function Base.:(==)(geo1::AbstractGeometry, geo2::AbstractGeometry)::Bool
    compare(==, geo1, geo2)
end
function Base.isequal(geo1::AbstractGeometry, geo2::AbstractGeometry)::Bool
    compare(isequal, geo1, geo2)
end
function Base.isapprox(geo1::AbstractGeometry, geo2::AbstractGeometry; kw...)::Bool
    compare(IsApprox(;kw...), geo1, geo2)
end
function compare(≅, geo1::AbstractGeometry, geo2::AbstractGeometry)::Bool
    (typeof(geo1) === typeof(geo2)) || return false
    ng1 = ngeom(geo1)
    ng2 = ngeom(geo2)
    ng1 == ng2 || return false
    for i in 1:ng1
        compare(≅, getgeom(geo1,i), getgeom(geo2,i)) || return false
    end
    return true
end

const HasCoordSeq = Union{LineString, LinearRing, Point}

function compare(≅, pt1::HasCoordSeq, pt2::HasCoordSeq)::Bool
    compare_coordseq(≅, pt1, pt2)
end

_numPoints(geo::Union{LineString,LinearRing}) = numPoints(geo)
_numPoints(geo::Point) = 1
function compare_coordseq(cmp, geo1::HasCoordSeq, geo2::HasCoordSeq, ctx=get_context(geo1))
    typeof(geo1) === typeof(geo2) || return false
    is3d = GeoInterface.is3d(geo1)
    is3d === GeoInterface.is3d(geo2) || return false
    npts = _numPoints(geo1)
    npts == _numPoints(geo2) || return false 
    GC.@preserve geo1 geo2 ctx begin
        seq1 = getCoordSeq(geo1)
        seq2 = getCoordSeq(geo2)
        unsafe_compare_coorseq(cmp, seq1, seq2, npts, is3d, ctx.ptr)
    end
end

function unsafe_compare_coorseq(cmp, seq1::GEOSCoordSeq, seq2::GEOSCoordSeq, npts, is3d, ctx::Ptr)
    X1 = Ref(NaN)
    Y1 = Ref(NaN)
    Z1 = Ref(NaN)
    X2 = Ref(NaN)
    Y2 = Ref(NaN)
    Z2 = Ref(NaN)
    GC.@preserve X1 Y1 Z1 X2 Y2 Z2 for i in 0:(npts-1)
        if is3d
            GEOSCoordSeq_getXYZ_r(ctx, seq1, i, X1, Y1, Z1)
            GEOSCoordSeq_getXYZ_r(ctx, seq2, i, X2, Y2, Z2)
        else
            GEOSCoordSeq_getXY_r(ctx, seq1, i, X1, Y1)
            GEOSCoordSeq_getXY_r(ctx, seq2, i, X2, Y2)
        end
        cmp(X1[], X2[]) || return false
        cmp(Y1[], Y2[]) || return false
        if is3d
            cmp(Z1[], Z2[]) || return false
        end
    end
    return true
end

function unsafe_compare_coorseq(cmp::IsApprox, seq1::GEOSCoordSeq, seq2::GEOSCoordSeq, npts, is3d, ctx::Ptr)
    X1 = Ref(NaN)
    Y1 = Ref(NaN)
    Z1 = Ref(0.0)
    X2 = Ref(NaN)
    Y2 = Ref(NaN)
    Z2 = Ref(0.0)
    s1 = 0.0
    s2 = 0.0
    s12 = 0.0
    for i in 0:(npts-1)
        if is3d
            GEOSCoordSeq_getXYZ_r(ctx, seq1, i, X1, Y1, Z1)
            GEOSCoordSeq_getXYZ_r(ctx, seq2, i, X2, Y2, Z2)
        else
            GEOSCoordSeq_getXY_r(ctx, seq1, i, X1, Y1)
            GEOSCoordSeq_getXY_r(ctx, seq2, i, X2, Y2)
        end
        x1 = X1[]; y1 = Y1[]; z1 = Z1[]
        x2 = X2[]; y2 = Y2[]; z2 = Z2[];
        s1 += x1^2 + y1^2 + z1^2
        s2 += x2^2 + y2^2 + z2^2
        s12 += (x1 - x2)^2 + (y1 - y2)^2 + (z1 - z2)^2
    end
    return sqrt(s12) <= cmp.atol + cmp.rtol * max(s1, s2)
end

typesalt(::Type{GeometryCollection} ) = 0xd1fd7c6403c36e5b
typesalt(::Type{PreparedGeometry}   ) = 0xbc1a26fe2f5b7537
typesalt(::Type{LineString}         ) = 0x712352fe219fca15
typesalt(::Type{LinearRing}         ) = 0xac7644fd36955ef1
typesalt(::Type{MultiLineString}    ) = 0x85aff0a53a2f2a32
typesalt(::Type{MultiPoint}         ) = 0x6213e67dbfd3b570
typesalt(::Type{MultiPolygon}       ) = 0xff2f957b4cdb5832
typesalt(::Type{Point}              ) = 0x4b5c101d3843160e
typesalt(::Type{Polygon}            ) = 0xa5c895d62ef56723

function Base.hash(geo::AbstractGeometry, h::UInt)::UInt
    salt = typesalt(typeof(geo))
    h = hash(salt, h)
    for i in 1:ngeom(geo)
        g = getgeom(geo,i)
        h = hash(g, h)
    end
    return h
end

function hash_coordseq(geo::HasCoordSeq, h::UInt, ctx=get_context(geo))::UInt
    seq = getCoordSeq(geo)
    npts = _numPoints(geo)
    is3d = GeoInterface.is3d(geo)
    X = Ref(NaN)
    Y = Ref(NaN)
    Z = Ref(NaN)
    GC.@preserve geo for i in 0:(npts-1)
        for i in 0:(npts-1)
            if is3d
                GEOSCoordSeq_getXYZ_r(ctx, seq, i, X, Y, Z)
                h = hash(X[], h)
                h = hash(Y[], h)
                h = hash(Z[], h)
            else
                GEOSCoordSeq_getXY_r(ctx, seq, i, X, Y)
                h = hash(X[], h)
                h = hash(Y[], h)
            end
        end
    end
    return h
end

function Base.hash(geo::HasCoordSeq, h::UInt)::UInt
    h = hash(typesalt(typeof(geo)), h)
    return hash_coordseq(geo, h)
end

# teach ccall how to get the pointer to pass to libgeos
# this way the Julia compiler will track the lifetimes for us
Base.unsafe_convert(::Type{Ptr{Cvoid}}, x::AbstractGeometry) = x.ptr
Base.unsafe_convert(::Type{Ptr{Cvoid}}, x::GEOSContext) = x.ptr
Base.unsafe_convert(::Type{Ptr{Cvoid}}, x::WKTReader) = x.ptr
Base.unsafe_convert(::Type{Ptr{Cvoid}}, x::WKTWriter) = x.ptr
Base.unsafe_convert(::Type{Ptr{Cvoid}}, x::WKBReader) = x.ptr
Base.unsafe_convert(::Type{Ptr{Cvoid}}, x::WKBWriter) = x.ptr

const GEOMTYPE = Dict{GEOSGeomTypes,Symbol}(
    GEOS_POINT => :Point,
    GEOS_LINESTRING => :LineString,
    GEOS_LINEARRING => :LinearRing,
    GEOS_POLYGON => :Polygon,
    GEOS_MULTIPOINT => :MultiPoint,
    GEOS_MULTILINESTRING => :MultiLineString,
    GEOS_MULTIPOLYGON => :MultiPolygon,
    GEOS_GEOMETRYCOLLECTION => :GeometryCollection,
)

function geomFromGEOS(ptr::Union{Geometry, Ptr{Cvoid}}, context::GEOSContext = get_global_context())
    id = geomTypeId(ptr, context)
    if id == GEOS_POINT
        return Point(ptr, context)
    elseif id == GEOS_LINESTRING
        return LineString(ptr, context)
    elseif id == GEOS_LINEARRING
        return LinearRing(ptr, context)
    elseif id == GEOS_POLYGON
        return Polygon(ptr, context)
    elseif id == GEOS_MULTIPOINT
        return MultiPoint(ptr, context)
    elseif id == GEOS_MULTILINESTRING
        return MultiLineString(ptr, context)
    elseif id == GEOS_MULTIPOLYGON
        return MultiPolygon(ptr, context)
    else
        @assert id == GEOS_GEOMETRYCOLLECTION
        return GeometryCollection(ptr, context)
    end
end
